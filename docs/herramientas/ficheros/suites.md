# Suites de Backup

Son herramientas enormes, generalmente con una interfaz web que funcionan en modo cliente servidor (con agentes instalados en los nodos), plugins para casos específicos (bases de datos), sistemas de monitorización, ...

Una de las herramientas más interesantes en este ámbito es Bareos.

## Bareos

-   https://github.com/bareos/bareos

Bareos es una suite de backup con licencia AGPL (no open-core, ni similar), desarrollado por una empresa que ofrece servicios y soporte sobre el software.

Funciona en base a tres componentes:

-   `Director`. El servidor. Se encarga de orquestar todo
-   `File Daemons`. El cliente. Se instala en el ordenador a copiar. Cifra todo en local antes de enviarlo. y lo envia al Storage Daemon. Admite plugins (ie: postgresql)
-   `Storage Daemon`. Que puede estar instalado en el mismo sitio que el Director. Se encarga de almacenar la info en local, S3, ...
-   `Catalog`. Base de datos. Un PostgreSQL donde se guarda toda la info y metadata de configuración, clientes, backups, ...

Nació en 2010 como un fork de Bacula. Pero tiene mejor documentación y es más clara la relación entre el producto comercial y el libre que con Bacula o Amada

Tiene plugin para [PostgreSQL](https://docs.bareos.org/TasksAndConcepts/Plugins.html#postgresql-plugin), y las opciones habituales de estas aplicaciones, deduplication, full/incremental/diferential, ...

## UrBackup

-   https://www.urbackup.org/

**Características:**

-   Cliente - Servidor
-   Usa SQLite como base de datos.
-   Copia ficheros (lógico) o hace imágenes (físico).
-   Interfaz web, ...
-   full e incremental. (tanto en lógico como en físico)
-   Clientes y server multiplataforma
-   Admite backup de PostgreSQL mediante wal y dumps. https://www.urbackup.org/backup_postgresql.html
-   Deduplication. Aunque sugieren usar btrfs
-   Pensado para almacenar las copias en local del servidor, no S3 o similar.
-   585 stars

UrgBackup puede ser una alternativa interesante a Bareos aunque tiene menos tracción

## Minarca

-   https://minarca.org/en_CA

Es cómo poner una interfaz web sobre rdiff-backup, donde ver estadísticas, lanzar alertas, ... En el cliente (windows, linux y mac) se instala un paquete también.

Las ventajas y problemas de rdiff-backup van también con Minarca.

Más útil como backup para equipos personales que para servidores.

## Otras herramientas de este tipo

-   [Bacula](http://www.bacula.org/). Muy potente pero pero también muy compleja de configurar
    -   https://www.spiceworks.com/tech/it-strategy/articles/amanda-vs-bacula-backup-software/
    -   https://www.digitalocean.com/community/tutorials/how-to-back-up-an-ubuntu-14-04-server-with-bacula
-   [Burp](https://github.com/grke/burp). Parece sencillo y potente, pero sólo tiene 0.5k stars en github. No se puede usar un sw de backup con poca tracción. Además no tiene binarios hay que compilarlo.
-   Amanda. Amanda es la versión libre de Zmanda. Ambos productos son desarrollados por la misma empresa en una especie de modelo open-core. Aunque las releases de Amanda parecen bastante por detrás de las de zmanda, y la relación entre ambas herramientas es compleja.
    -   https://www.amanda.org/
    -   https://www.zmanda.com/amanda-community/
    -   https://github.com/zmanda/amanda/
    -   https://wiki.zmanda.com/index.php
