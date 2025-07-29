# Segmentar las fuentes de datos

A pesar de haber sido tratado en otras secciones debe hacerse hincapié en que no toda la información de origen tiene el mismo valor y características.

La estrategia de copias puede tenerlo en cuenta para optimizar recursos. A sabiendas de que introducir mecanismos distintos según el conjunto de datos complicará el sistema general.

Este análisis se puede hacer desde el punto de vista de la "criticidad" pero complementariamente se puede hacer una clasificación por tipo u objetivo del dato.

## Tipos de datos para backup

### Aplicación, Binarios, Configuración, etc

Salvo que usemos un sistema de clonado no deberíamos preocuparnos por esta información. La restauración del sistema a este nivel, debería poder ser realizada con los mismos automatismos que usemos para el provisionamiento.

Aún así el esfuerzo de copiar ciertos datos cómo `/etc/` o un listado de los paquetes instalados en el sistema (`apt list --installed`) tiene un coste reducido y puede ahorrar problemas.

#### Configuración

-   **Características**: Crucial para la operación, volumen pequeño
-   **Ejemplos**: Archivos de configuración en /etc, virtualhosts de Apache
-   **Consideraciones especiales**:
    -   Idealmente gestionada como Infrastructure as Code
    -   Backup tras cambios planificados
    -   Documentación de cambios manuales

#### Código de aplicación

-   **Características**: Debe estar versionado en repositorio
-   **Consideraciones especiales**:
    -   No requiere backup tradicional si existen mecanismos de despliegue apropiados

### Bases de datos

Es uno de los activos que claramente habrá que respaldar.

-   **Características**: Almacén central de información, acceso constante
-   **Consideraciones especiales**:
    -   Consistencia transaccional
    -   Herramientas específicas según motor (pg_dump, pg_basebackup)
    -   Balance entre backups lógicos y físicos
    -   Integración con logs transaccionales para PITR

### Ficheros grandes de larga duración (Big long term files)

En aplicaciones corporativas son muchas veces ficheros que se proveen con la propia aplicación y no información que modifica el cliente. Muchas veces pueden ser "recreados" por lo que los backups están más relacionados con el RTO qué con la pérdida de datos.

-   **Características**: Voluminosos (decenas o cientos de GB), raramente modificados
-   **Ejemplos**: Datos ráster para GIS, MDTs para geoprocesos, datasets de machine learning
-   **Consideraciones especiales**:
    -   La estrategia inicial debe ser un backup completo
    -   Backups incrementales o diferenciales muy espaciados
    -   Verificación de integridad especialmente importante
    -   Posible almacenamiento en medios de menor coste

### Ficheros de corta duración (Short term files)

Lo que en aplicaciones corporativas puede denominarse _adjuntos_. Estos ficheros son muchas veces tan críticos cómo la base de datos y están muy ligadas a ella, por lo que deberían tener las mismas políticas de periodicidad y retención.

-   **Características**: Modificados frecuentemente, tamaño variable
-   **Ejemplos**: Archivos subidos por usuarios, documentos en edición activa
-   **Consideraciones especiales**:
    -   Backups frecuentes
    -   Estrategias incrementales o diferenciales
    -   Posible necesidad de versionado

### Contenedores (docker)

Los contenedores podrían tratarse de forma especial pero es más sencillo gestionarlo cómo los otros tipos: Configuración, Binarios, Bases de Datos y Ficheros. Simplemente hay que tener precaución con los volúmenes y gestionarlos como IaC.
