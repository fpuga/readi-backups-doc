# Estilo cp

## rclone

Dentro de estas herramientas merece la pena destacar `rclone`. rclone es un programa de línea de comandos, estilo rsync, pero con más opciones para trabajar con "cloud storage providers" como S3, Google Drive y protocolos FTP, WebDav, ...

-   https://github.com/rclone/rclone
-   Tiene muchísimas opciones, limitar el ancho de banda, cifrado, checksums, servir ficheros por http, ftp, ...
-   Tiene un modo de control remoto, donde activa un servidor http que se puede controlar mediante API JSON REST
-   Los ficheros en el storage provider se pueden usar de la forma normal que permita el storage.
-   No hace envíos parciales, "sincroniza" ficheros enteros que hayan cambiado.

Es una herramienta interesante, y puede complementar a otras opciones de backup, pero no es una herramienta de backup en sí. No implementa nada de `retention policy`, ni monitorización, ...
