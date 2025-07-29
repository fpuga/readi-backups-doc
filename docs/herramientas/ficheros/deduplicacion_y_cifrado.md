# Herramientas de deduplicación y cifrado a nivel de bloque

Estas herramientas operan a un nivel más bajo, fragmentando los archivos en bloques, deduplicando estos bloques para ahorrar espacio y cifrándolos.

-   [restic](https://github.com/restic/restic)
-   [borgbackup](https://github.com/borgbackup/borg/)

Son opciones modernas, recomendadas para la mayoría de entornos.

La elección entre restic y borgbackup a menudo se reduce a preferencias personales, los backends de almacenamiento deseados (restic más flexible para la nube, borgbackup más centrado en SSH) y algunas características específicas (compresión de borgbackup, simplicidad de restic, consumo de RAM elevado de restic, ...).

Ambas herramientas tienen bastantes similitudes.

-   No trabajan con los ficheros en sí. Manejan el concepto de repositorio donde lo que se almacenan son "bloques de bytes" y no ficheros. Por tanto no se puede trabajar directamente con la copia si no que hay que hacerlo a través de las herramientas.
-   Son más complejas que las `rsync-based` y requieren más precauciones de verificación de las copias, pruebas de restauración, ... Pero ambos incluyen funcionalidades para verificar el repositorio y sistemas fuertes para evitar la corrupción
-   Ambas tienen funcionalidades de deplicación (si hay dos bloques iguales sólo lo almacena una vez en disco ahorrando espacio) y cifrado (se cifra en origen por lo que se pueden almacenar los datos en sitios "poco fiables")
-   Ambas pueden suponer un mayor consumo de CPU y RAM que las `rsync-based` en ciertas operaciones, bien del lado cliente, bien del lado servidor.
-   Aunque ambos admiten compresión, la de borg parece mejor
-   Ambos admiten cifrado, pero el de restic es mejor
-   borg funciona únicamente a través de SSH. restic, directamente o través de rclone soporta más tipos de almacenamiento (SSH, HTTP Rest, S3, ...)
-   Ambos funcionan en modo push y soportan el modo append-only aunque con diferencias. En borg debe configurarse a través de SSH (authorized_keys, ...) en restic puede hacerse a través de restic-server o ssh ([con matices](https://marcusb.org/posts/2024/07/ransomware-resistant-backups-with-borg-and-restic/)).
-   Ambas son herramientas rápidas y hay comparativas que tiran hacia un lado o hacia otro sin conclusiones claras. En principio restic es más rápido que borg pero consume más espacio en disco y ancho de banda.
-   En algunos casos restic llega a consumir mucha RAM, y puede llegar a bloquear el servidor.
-   Una diferencia que puede ser importante es que el modelo de Borg es 1 servidor, 1 repositorio. Mediante que Restic permite almacenar varios servidores en el mismo repositorio (con deduplication entre varios servers por tanto). Pero debe valorarse adecuadamente si es buena idea tener varios servidores en el mismo repositorio. Uno de los problemas es que si un servidor tiene acceso al repositorio, tendrá acceso a todo el repositorio, no sólo a su "parte".
-   Borg funciona en Linux/Mac. Restic también funciona en Windows.
-   Ambos tienen un ecosistema amplio, GUIs, wrappers que añaden funcionalidad, proveedores comerciales con soporte específico, herramientas web, integración con sistemas de monitorización. El complemento por excelencia para restic es [resticprofile](https://github.com/creativeprojects/resticprofile) y [restic-server](https://github.com/restic/rest-server), y para borg es [borgmatic](https://projects.torsion.org/borgmatic-collective/borgmatic).

## Referencias

-   https://dataswamp.org/~solene/2021-05-21-borg-vs-restic.html
-   https://www.hostinger.com/blog/restic-borg
-   https://nick.groenen.me/archive/2021/2021-10-10-comparison-between-restic-and-borg-backup/
-   https://it-notes.dragas.net/2020/06/30/searching-for-a-perfect-backup-solution-borg-and-restic/
-   https://stickleback.dk/borg-or-restic/
-   https://www.reddit.com/r/BorgBackup/comments/v3bwfg/why_should_i_switch_from_restic_to_borg/
-   https://www.somebits.com/weblog/tech/good/restic.html
