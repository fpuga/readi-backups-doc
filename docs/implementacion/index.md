# Implementación

En esta sección se describe la implementación práctica de la estrategia genérica de copias de seguridad de iCarto.

Esta estrategia se emplea para la mayoría de servidores internos y de clientes, aunque existen casos específicos para los que se usan otras estrategias.

## Contexto

iCarto es una empresa de consultoría tecnológica pequeña.

-   Realiza consultoría tecnológica y fortalecimiento institucional
-   Crea, Analiza, Mantiene y Disponibiliza "datos" para ámbitos diversos
-   Desarrolla aplicaciones a medida y Sistemas de Información
-   Proporciona soporte técnico especializado en áreas cómo los Sistemas de Información Geográfica
-   Mantiene los sistemas en producción

Esta actividad se desarrolla para clientes públicos y privados de distintas partes del mundo, especialmente en contextos de bajas capacidades tecnológicos, o sin capacidad para administrar los sistemas.

El equipo mantiene más de 15 servidores de producción. Estos servidores pueden estar en on-premises propio o del cliente, y proveedores cloud propios (Linode) o del cliente. Cada infraestructura tiene sus particularidades (VPN, ...)

Las bases de datos van desde unas decenas de megas, hasta los ~100GB. Los ficheros adjuntos y otros assets estáticos se mueven en los mismos rangos.

La mayoría de nuestros sistemas se pueden considerar _corporativos_, se usan únicamente en horario de oficina según la zona horaria en que se encuentren.

## Necesidades y discusión de la solución

### Soberanía tecnológica

iCarto apuesta por la soberanía tecnológica de las organizaciones con las que trabaja. Queremos que nuestros clientes puedan apropiarse de la infraestructura en el futuro. Eso implica reducir las dependencias de proveedores comerciales, software complejo, centralización, ...

Las [suites de backup](../herramientas/ficheros/suites.md) (Bareos, ...) o proveedores cloud comerciales de backups, aportan en una solución integral la mayoría de necesidades de backups (configuración, monitorización, políticas de retención complejas, ...). Permiten ver el estado general de los backups, si algo falló, el volumen ocupado, ir a la versión (o fichero) concreto que se quiere restaurar. A cambio suponen una enorme centralización y/o un grado alto de _expertise_.

Las descartamos porqué es difícil que el cliente pueda hacerse cargo en algún momento de esa infraestructura.

Optaremos en general por soluciones que permitan la descentralización y sean de software libre (preferiblemente con soporte comercial)

## PostgreSQL

Las tecnologías para hacer copias de seguridad de PostgreSQL son variadas y pueden llegar a ser muy complejas. Pero en muchas aplicaciones cómo las empresariales usadas en horario laboral se pueden definir estrategias y tecnologías sencillas que cumplan con necesidades exigentes.

Nuestra propuesta de backup para PostgreSQL se basa en que:

-   Consideramos la replicación de bases de datos un mecanismo de Alta Disponibilidad (HA) y no de backups. Los sistemas de HA empleados cómo sistema de backups tienen inconvenientes respecto a otras estrategias que no merece la pena considerar. La estrategia que planteamos funciona no obstante incluso en entornos active-active qué admitan perdidas de conexión temporales (ie: con bucardo)
-   La mayoría de herramientas de backup para PostgreSQL parten de la premisa de evitar los _downtime_. Cuando apagar la base de datos es factible en ciertas ventanas (de madrugada) los problemas se simplifican.
-   PITR, recuperar el estado en un punto concreto reconstruyendo las transaciones a partir de un backup, no es necesario. Llega con la granularidad que aportan los backups (por ejemplo diaria)

Estas premisas, casi, nos permiten ignorar la existencia de una base de datos, y entenderla únicamente cómo ficheros en el disco duro. Es _good enough_ emplear la misma herramienta que se use para el resto de ficheros.

Aunque debe tenerse en cuenta que:

-   Copiar ficheros directamente (al igual que `pg_basebackup` y similares) está muy acoplado a la versión, extensiones, [versiones de las librerías de collation](https://www.postgresql.org/docs/current/collation.html), ... del cluster concreto de PostgreSQL que se esté copiando.
-   Es necesario mantener un registro de que versión va con que backup, y resto de "metadatos" que permitan reproducir el entorno
-   Las pruebas de restauración y verificación son más críticas (y complicadas) de lo habitual
-   La estructura de la base de datos (tablas muy grandes, muchas tablas, cantidad de cambios, ...) afectará mucho al espacio de almacenamiento y ancho de banda según el tipo de backup (full, incremental, ...) y a cómo funcione la herramienta:
    -   Por ejemplo `rdiff-backup` trabaja mediante deltas, sólo envía los cambios en el fichero. Es bueno para ficheros/tablas grandes con cambios regulares pero hará más lenta encontrar un cambio concreto y la recuperación. `rsnaphost` trabaja con enlaces y ficheros enteros. Un cambio mínimo en una tabla grande significa la retransmisión completa del fichero.

Así que en nuestro caso la tarea programada de backups apaga la base de datos y resto de servicios, provocando el _flush_ a disco de la información. Se lleva a cabo la creación del backup mediante borgmatic que es bastante eficiente en la detección y almacenamiento de únicamente los cambios.

## Contenedores

Los contenedores son gestionados de forma similar a PostgreSQL. La configuración, ... se gestiona mediante las herramientas de provisionamiento / IaC / ... Los paramos antes de realizar el backup y se hace una copia de los volúmenes de interés.

## Modelo de Amenaza

Manejamos servidores que no pueden ser accedidos desde el exterior de la red. Esto hace que los [modelos pull](../marco_teorico/pull_vs_push.md) no sean una buena opción.

El uso de servidores intermedios en un modelo _push + pull_ aumenta la complejidad y los costes de forma exponencial.

El problema de los modelos _push_ es que un incidente en cascada (generalmente un ataque intencionado estilo randomware a producción) puede destruir las copias. Por ello optamos por un modelo _push + append-only_. El servidor de producción puede añadir datos, pero no modificar los datos ya almacenados, lo que protege de ese tipo de ataques. Este modelo permite además que un _hackeo_ del backup no de acceso a producción.

Se asume que el servidor de backups podría verse comprometido por ello los datos se cifran en origen.

El punto más crítico en este modelo es el nodo desde el que se pueden automatizar las tareas de los servidores de producción. Para reducir el riesgo este nodo no tiene acceso al sistema de almacenamiento. Todas las tareas sobre el servidor de almacenamiento se realizan de forma manual con las credenciales de acceso aisladas de otros sistemas.

## Otras consideraciones

-   Es muy poco habitual que nos soliciten recuperar un fichero antiguo concreto. Por lo que técnicas cómo _reverse incremental_ o herramientas cómo rdiff-backup no serían un problema. Con herramientas cómo borg o restic recuperar ficheros individuales no es problemático.
-   En las herramientas que funcionan sobre ssh (sin append-only) debe usarse pull.
    -   La copia debe ver la red (vpn, firewall, ...).
    -   Debe crearse un usuario de sólo lectura sobre los datos a copiar. Si no un atacante que se haga con el backup podría destruir el origen
    -   Debe tenerse en cuenta que algunos datos pueden pertenecer a usuarios/grupos cómo tomcat/apache/postgres/... por lo que la configuración de permisos puede ser compleja
-   Retención flexible. El sistema debe proporcionar una política de retención flexible adaptada a cada sistema.
