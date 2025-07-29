# Basadas en rsync

## rsnaphost y rdiff-backup

Ambas son herramientas históricas de backup ampliamente usadas.

La mayor diferencia es que rsnaphost para cada copia, genera una carpeta con todos los ficheros. Cuando un fichero es igual entre copias simplemente usa un hardlink, cuando cambia almacena el fichero completo. El recuperar una versión antigua de un fichero no requiere de ningún programa en especial, se puede hacer con un simple cp, en este sentido la recuperación de la copia de seguridad o de un fichero de una fecha concreta es transparente para el usuario.

rdiff-backup almacena los ficheros completos de la última copia. Pero para la retención, funciona en modo _reverse incremental_ almacena los _reverse delta_ (cambios a nivel bloque entre los ficheros). Para recuperar un fichero de una copia antigua deben usarse las herramientas de rdiff-backup.

rdiff-backup es más lento que rsnapshot y consume más CPU por la necesidad de calcular las delta. Además almacena los metadatos (permisos, ...) de forma separada, y es más "complejo" por lo que el riesgo de error es mayor.

Ambas se basan en el algoritmo de rsync para la transferencia. Sólo envía el cambio, no necesita enviar el fichero completo.

Ambas realizan la transferencia mediante ssh (o samba, nfs, ...), con todo lo que ello implica:

-   Permisos de escritura en la copia si es push, con lo que un atacante podría arruinar la copia.
-   En pull la copia debe tener acceso al servidor (firewalls, ...) Debe existir un usuario específico con permisos de sólo lectura, teniendo en cuenta que ciertos ficheros pueden tener permisos de root/postgres/...

La política de retención de `rdiff-backup` es muy limitada. Sólo permite eliminar las copias anteriores a una determinada fecha "Borra lo que tenga más de dos semanas". Pero para estrategias cómo mantén lo de hace un 1 año, y una versión por mes de los últimos 6 meses, habrá sido necesario que el script de copia haya generado copias separadas. `rsnapshot` permite políticas de retención mucho más flexibles.

Para ficheros grandes que cambian a menudo `rdiff-backup` ocupa mucho menos espacio.

rdiff-backup en general ahorrará espacio sobre rsnapshot, sobre todo cuando tengas ficheros grandes que cambien a menudo (ficheros de bases de datos, ...). A nivel espacio:

-   ficheros (sobre todo si son grandes) que varían mucho. rdiff-backup optimiza el espacio
-   ficheros que varían poco. más o menos indiferente.
-   cuando se creen muchos ficheros nuevos, más o menos indiferente.
-   muchos archivos pequeños que cambian frecuentemente. rdiff-backup es lento.

La conclusión podría ser que si se necesita ahorrar espacio `rdiff-backup` es la mejor solución. Si la retención y recuperación es una prioridad, mejor usar rsnapshot.

**Referencias:**

Comparativas:

-   https://github.com/rdiff-backup/rdiff-backup
-   https://github.com/rsnapshot/rsnapshot
-   https://www.saltycrane.com/blog/2008/02/backup-on-linux-rsnapshot-vs-rdiff/
-   https://www.linode.com/docs/guides/using-rdiff-backup-with-sshfs/
-   https://www.tecmint.com/rsnapshot-a-file-system-backup-utility-for-linux/

## Duplicity

-   https://duplicity.gitlab.io/
-   https://www.cyberciti.biz/faq/duplicity-installation-configuration-on-debian-ubuntu-linux/

Es muy parecido a rdiff-backup. La principal diferencia es que rdiff-backup crea un sistema de archivos en remoto, mientras que duplicity un "tar comprimido y cifrado".

Ventajas:

-   Soporta muchos "protocolos de transferencia": scp/ssh, ftp, rsync, WebDAV, S3
-   Es capaz de firmar y cifrar los ficheros en el destino

Desventajas:

-   Usa _incremental_, y no _reverse incremental_, por tanto recuperar la copia actual implica usar las herramientas de duplicity, y tienen más riesgo de corrupción.

Lo peor que tiene como herramienta corporativa es que no permite establecer con la propio herramienta una política de retención buena.

No es un mal software. Muy parecido a rdiff-backup. En principio hay frontends escritos sobre él y debería haber muchos scripts potentes hechos, pero en la documentación (que está bien, pero no super, tampoco listan ninguno bueno). Le falta un poco del "enterprise" que si tiene borg, como atención contra hacking, motorización, ...
