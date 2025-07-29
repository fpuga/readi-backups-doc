# Herramientas de backup para PostgreSQL

Hay decenas de herramientas para realizar copias de seguridad de PostgreSQL.

-   [Listado de herramientas](https://severalnines.com/blog/current-state-open-source-backup-management-postgresql)
-   [Resumen de tecnologías de backup para PostgreSQL](https://www.percona.com/blog/postgresql-backup-strategy-enterprise-grade-environment/)
-   [Diferencia entre Alta Disponibilidad y Recuperación ante Desastres](https://blog.crunchydata.com/blog/database-terminology-explained-postgres-high-availability-and-disaster-recovery)

Las más usadas son:

-   pg_dump / pg_dumpall
-   pg_basebackup
-   pgBackRest
-   barman

Otras herramientas con menos tracción pero que pueden encajar en algunos casos de uso son:

-   https://github.com/postgrespro/pg_probackup
-   https://github.com/ossc-db/pg_rman
-   https://github.com/pgmoneta/pgmoneta
-   https://github.com/Aiven-Open/pghoard
-   https://github.com/wal-g/wal-g

## pg_dump / pg_dumpall

Hay quien considera que pg_dump no es una herramienta de backup. Nosotros las incluímos en el tipo de backups lógicos.

pg_dump admite muchas opciones que lo hacen flexible:

-   **Formato**: custom/plain/tar/directory.

    -   `plain` Generan un fichero .sql. No se deberían usar para backups.
    -   `tar` No se debería usar para backups porqué es poco flexible.
    -   `custom` es la mejor opción para bases de datos pequeñas (< 10GB) o donde el tiempo de backup/restore no sea fundamental. El dump se puede manipular (tabla de contenidos, ...) antes del restore.
    -   `directory` más incomodo que custom porqué genera un fichero separado por cada tabla y blob. Permite lanzar varios procesos en paralelo con la opción `-j` tanto en backup como en restore, mejorando la velocidad. El resultado se puede pasar luego a `tar` para gestionar un sólo archivo.

-   **Selectividad**. Tiene opciones para excluir o incluir patrones de tablas y esquemas, blobs, contenido y/o esquema, ...

pg_dump trabaja a nivel base de datos no a nivel cluster. Para exportar objetos que pertenecen al cluster (sobre todo usuarios) debe emplearse `pg_dumpall`. `pg_dumpall` es menos flexible que `pg_dump` por lo que ambas herramientas deben combinarse.

El sistema de copia debe tener en cuenta:

-   Gestionar la copia a través de un script, generalmente en bash y programado mediante cron o systemd
-   Permisos de acceso a la base de datos (red y usuarios)
-   La retención deben hacerse mediante la fecha o nombre de los archivos
-   Debe pensarse bien la estrategia de push / pull

## pg_basebackup

Es una herramienta de "backup físico" nativa de PostgreSQL. Combinándola con WAL permite PITR.

Funciona a nivel cluster y sistema de ficheros. No permite "seleccionar" lo que se quiere copiar, ni necesita "permisos" en PostgreSQL.

El sistema de copia debe realizarse a través de un script que tenga en cuenta los problemas habituales y mover el archivo al servidor de backups.

-   [Ejemplo de uso](https://www.zimmi.cz/posts/2018/postgresql-backup-and-recovery-orchestration-wal-archiving/) de `pg_basebackup` con PITR mediante WAL y script programado con systemd
-   A partir de la versión 17 los backups pueden ser incrementales o diferenciales de forma nativa:
    -   [Incremental Backups in PostgreSQL 17](https://stokerpostgresql.blogspot.com/2025/04/incremental-backups-in-postgresql-17.html)
    -   [Waiting for PostgreSQL 17 – Add support for incremental backup](https://www.depesz.com/2024/01/08/waiting-for-postgresql-17-add-support-for-incremental-backup/)

## pgBackRest y Barman

Ambas son dos buenas herramientas, cada una con sus características. Cada una mantenido por una empresa distinta.

-   [pgbackrest vs pgbarman](https://mydbanotebook.org/post/how-to-do-proper-backups/)

### pgbackrest

-   https://pgbackrest.org/
-   http://www.pgdba.org/post/fun_pgbackrest/
-   https://www.percona.com/blog/pgbackrest-restoration-scenarios/
-   https://severalnines.com/blog/validating-your-postgresql-backups-docker/

### pgbarman

-   https://pgbarman.org/
-   https://www.2ndquadrant.com/en/blog/pg-phriday-adventures-in-bar-management/
-   https://severalnines.com/blog/using-barman-postgresql-disaster-recovery/
-   https://severalnines.com/blog/using-barman-backup-postgresql-overview/

## Tabla comparativa de herramientas para PostgreSQL

| Característica                    | pg_dump/pg_restore                   | Barman            | pg_basebackup   | WAL-G          | pgBackRest          |
| --------------------------------- | ------------------------------------ | ----------------- | --------------- | -------------- | ------------------- |
| **Tipo de backup**                | Lógico                               | Lógico y físico   | Físico          | Físico         | Físico              |
| **Backups incrementales**         | No                                   | Sí                | Sí (>v17)       | Sí             | Sí                  |
| **PITR (Point-in-Time Recovery)** | No                                   | Sí                | Sí (con WAL)    | Sí             | Sí                  |
| **Compresión**                    | Sí                                   | Sí                | Sí              | Sí             | Sí                  |
| **Cifrado**                       | No (manual)                          | Sí                | No (manual)     | Sí             | Sí                  |
| **Paralelización**                | Limitada                             | Sí                | Limitada        | Sí             | Sí                  |
| **Verificación automática**       | No                                   | Sí                | No              | Sí             | Sí                  |
| **Almacenamiento en nube**        | No (manual)                          | Limitado          | No (manual)     | AWS/GCS/Azure  | AWS/GCS/Azure       |
| **Deduplicación**                 | No                                   | No                | No              | Sí             | Sí                  |
| **Interfaz web**                  | No                                   | No                | No              | No             | No                  |
| **Complejidad de configuración**  | Baja                                 | Media             | Baja            | Media          | Alta                |
| **Madurez**                       | Alta                                 | Alta              | Alta            | Media          | Alta                |
| **Mejor para**                    | Bases pequeñas, esquemas específicos | Solución completa | Backups rápidos | Entornos cloud | Alta disponibilidad |
