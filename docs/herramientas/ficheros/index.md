# Herramientas para backup de ficheros

Hay muchísimas buenas herramientas para copias de seguridad. Son difíciles de categorizar porqué muchas cumplen más de una función o permiten más de un estilo, pero hacerlo ayuda a entender las opciones.

Una posible clasificación es:

-   **Backup del Proveedor Cloud**. Los proveedores cloud proporcionan sus propios sistemas de backup.
-   **Snapshots y Mirrors**. Incluimos en esta categoría sistemas de ficheros cómo BTFRS, configuraciones hardware como ciertos RAID, y capacidades de los sistemas de virtualización. Son sistemas que en general funcionan _on-site_ y necesitan complementarse con una herramienta de _backups tradicional_.
-   **Herramientas de clonado**. Se basan en hacer una copia física del disco duro. Son útiles en servidores físicos o para reproducir máquinas exactas pero tienen menos sentido en un ambiente cloud o cómo herramientas de backup.
-   **Suites de Backup**. Son herramientas enormes, generalmente con una interfaz web que funcionan en modo cliente servidor (con agentes instalados en los nodos), plugins para casos específicos (bases de datos), sistemas de monitorización, ...
-   **Estilo cp**. Herramientas como `scp`, `rsync` o `rclone` pueden sacarnos de un apuro pero no deberían ser usadas, ya que hay opciones mejores más enfocadas a backup.
-   **Basadas en rsync**. Herramientas de consola basadas en rsync, con funcionalidades de backup: `rsnaphost`, `rdiff-backup`, `duplicity`
-   **Herramientas de deduplicación y cifrado a nivel de bloque**. Herramientas pensadas desde el principio para backups enfocadas al ahorro de espacio, y con modelos de amenazas fuertes: `borgbackup`, `restic`.

**Listados de herramientas:**

-   https://www.tecmint.com/linux-system-backup-tools/
-   https://www.tecmint.com/linux-disk-cloning-tools/
-   https://www.ubuntupit.com/free-open-source-backup-software-for-linux/
-   https://askubuntu.com/questions/2596/comparison-of-backup-tools/
-   https://opensource.com/article/19/3/backup-solutions
-   https://wiki.archlinux.org/index.php/Synchronization_and_backup_programs
-   https://askubuntu.com/questions/2596/comparison-of-backup-tools/
