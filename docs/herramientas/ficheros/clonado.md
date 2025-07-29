# Herramientas de clonado

Se basan en hacer una copia física del disco duro. Son útiles en servidores físicos o para reproducir máquinas exactas pero tienen menos sentido en un ambiente cloud o cómo herramientas de backup.

Muchas de ellas funcionan o están integradas en un disco de arranque que puede incluir funcionalidades diversas para recuperar un sistema cómo reinstalar el boot.

## dd

Es una herramienta de consola instalada por defecto. Permite crear imágenes de disco con facilidad. Muy potente pero hay que usarla con precaución porqué es fácil cometer algún error que arruine la copia o el sistema.

Las imágenes que genera pueden montarse sin necesidad de restaurarlas realmente en un sistema.

## Clonezilla

-   https://clonezilla.org/
-   https://www.tecmint.com/linux-centos-ubuntu-disk-cloning-backup-using-clonezilla/
-   https://www.maketecheasier.com/clone-drives-and-partitions-with-clonezilla/
-   https://www.howtoforge.com/tutorial/clone-encrypted-disk-image-with-clonezilla/

Clonezilla es una de las mejores aplicaciones para clonar discos o particiones y hacer backups. Puede clonar directamente un disco a otro, o generar un fichero .img (raw image)

Tiene dos variantes:

-   Live. Un Live CD (o USB) con una aplicación de consola e interfaz basada en ncurses
-   Server. Que permite clonar hasta 40 equipos de forma simultánea.

## Otras herramientas

-   PING. https://ping.windowsdream.com/
-   G4L. https://sourceforge.net/projects/g4l/
-   https://github.com/rear/rear
-   Partclone. https://github.com/Thomas-Tsai/partclone
-   FSArchiver. https://github.com/fdupoux/fsarchiver
