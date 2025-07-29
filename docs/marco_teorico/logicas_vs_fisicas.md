# Copias lógicas vs físicas

Otra característica de las copias de seguridad es si estás se hacen a nivel _lógico_ o a nivel _físico_.

## En base de datos

En las bases de datos la información se persiste a ficheros en el disco duro, [aproximadamente un fichero por tabla](https://www.postgresql.org/docs/current/storage-file-layout.html). Pero los datos no se consolidan en estos ficheros de forma inmediata tras una operación. Para asegurar la integridad y el rendimiento se usan técnicas que implican el uso de la RAM y "ficheros intermedios".

Esto es relevante para entender porqué hay que tener muchas precauciones para hacer una copia de la base de datos simplemente copiando los ficheros en disco. Y de ahí se deriva la importancia de entender la diferencia entre copias lógicas y físicas.

-   [Beneficios de las copias lógicas vs físicos](https://www.percona.com/blog/postgresql-101-simple-backup-and-restore/)

### Lógica

En el nivel **lógico** la copia en sí es una representación ya consolidada de los datos. Generalmente usando el formato SQL, o formatos binarios propios. Realizadas habitualmente con `pg_dump`.

Ofrecen:

-   Flexibilidad: Permiten realizar copias de seguridad y restaurar tablas o subconjuntos de datos específicos, lo cual es ideal para bases de datos grandes, ahorrando tiempo y recursos.
-   Portabilidad: Se pueden transferir fácilmente entre diferentes instancias de PostgreSQL o incluso entre distintos sistemas de gestión de bases de datos, siendo útiles para la migración de datos.
-   Transparencia: Son legibles por humanos, lo que facilita la inspección, modificación y resolución de problemas.
-   Espacio: Un full backup en formato lógico ocupará en general menos que en formato físico

Desventajas:

-   No tienen modo incremental. Siempre es full backup
-   Se necesita combinar herramientas. Hay objetos de la bd como los usuarios que no se exportan con pg_dump y es necesario usar pg_dumpall.
-   Se debería hacer un ANALYZE tras el restore haciéndolo aún más lento.

### Físico

En el nivel **físico** se trabaja es con los ficheros en disco, usando herramientas como `pg_basebackup`, y que con muchos matices podríamos asimilar a hacer un copy&paste de los ficheros.

Ofrecen:

-   Mayor velocidad: Son más rápidas que las copias lógicas.
-   Flexibilidad en la estrategia: Ofrecen una gran flexibilidad para que los administradores de bases de datos personalicen su enfoque de respaldo, incluyendo copias de seguridad completas, incrementales y diferenciales.
-   Ideales para grandes bases de datos: Cuando deben gestionarse downtimes, retención de datos, ...
-   Admiten modo incremental, PITR, ...
-   Permiten llegar a un RPO de 0. Es decir hacer un backup continuo de modo que nunca haya perdida de datos o por ejemplo pueda recuperar una versión de una hora y día concreto. Es un problema de rendimiento y espacio. Cuantas "más versiones" más estresaremos la bd con los backups (menos rendimiento para otras cosas) y más espacio en disco ocupado.
-   Recuperar una tabla concreta generalmente implica restaurar en un servidor adicional el cluster entero, exportar la tabla e importarla en el servidor de producción.

Desventajas:

-   Más complejidad
-   Dependen de la versión de la bse de datos y de las extensiones instaladas
-   No son selectivas sobre que conjunto de datos copiar. Se exporta todo el cluster generalmente.

## En disco

Para los ficheros en disco se puede hacer una diferenciación similar.

El nivel físico en disco son "bloques de bytes", 1 y 0, que son transformados por el sistema operativo y el sistema de ficheros, en archivos con datos. Cuando se habla de herramientas de clonado de disco (cómo `dd`) y generalmente también de herramientas de _snapshots_ nos referimos a este nivel.

-   Ventajas: Copias exactas incluyendo sistema operativo, boot sectors, etc. Rápidas en full backups.
-   Desventajas: Requieren espacio equivalente al original, no selectivas.

El nivel lógico es aquel que se hace a nivel fichero en sí. "Copiar y Pegar" los ficheros sería un ejemplo de copia de seguridad a nivel lógico.

-   Ventajas: Selectivas, eficientes en espacio (en incremental), independientes del sistema de ficheros
-   Desventajas: Más lentas para conjuntos grandes de ficheros pequeños
