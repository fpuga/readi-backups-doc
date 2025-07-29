# Proveedores de almacenamiento

El uso de un proveedor cloud para el almacenamiento de la copia diferente a nuestro proveedor principal o a nuestra infraestructura _on-premises_ puede aumentar la resiliencia del sistema.

Un proveedor de almacenamiento externo permite mantener las copias en una infraestructura separada a la de producción, generalmente a precios asequibles, y en algunos casos ofreciendo funcionalidades extras, cómo sistemas sencillos de monitorización y alertas.

En una primera clasificación podemos dividir los proveedores en tres grandes categorías.

-   VPS especialmente pensados para backups o con almacenamiento barato
-   Object Storage compatible con S3
-   Almacenamiento especialmente enfocado a Backup

A continuación se presentan algunas opciones. En ningún caso se trata de una recomendación, e iCarto no está afiliado con ninguno de ellos. Se trata sólo de una visión de alto nivel de las opciones.

Deben tenerse en cuenta características particulares cómo el hardware que emplean, APIs, ...

## VPS

| Proveedor | RAM | CPU   | Disco | Transferencia | Coste | Notas                                          |
| --------- | --- | ----- | ----- | ------------- | ----- | ---------------------------------------------- |
| HostHatch | 1GB | 1 CPU | 1TB   | 2.5TB         | 5$    | https://hosthatch.com/products#storage         |
| HostHatch | 2GB | 2 CPU | 4TB   | 10TB          | 16$   | https://hosthatch.com/products#storage         |
| AlphaVPS  | 2GB | 2 CPU | 1TB   | 3TB           | 4€    | Europeo. https://alphavps.com/storage-vps.html |
| AlphaVPS  | 4GB | 4 CPU | 4TB   | 10TB          | 16€   | Europeo. https://alphavps.com/storage-vps.html |

## S3

| Proveedor    | Coste / TB | Notas                                                    |
| ------------ | ---------- | -------------------------------------------------------- |
| Scaleway     | 12€        | Europeo. https://www.scaleway.com/en/pricing/storage/    |
| Upcloud      | 20€        | Europeo. https://upcloud.com/products/object-storage     |
| Intercolo    | 5€         | Europeo. https://intercolo.de/en/object-storage          |
| Hetzner      | 6€         | Europeo. https://www.hetzner.com/storage/object-storage/ |
| Backblaze B2 | 6$         | https://www.backblaze.com/cloud-storage/pricing          |

## Enfocados a backup

Productos especialmente enfocados a backup y archivo que no son S3

| Proveedor | Coste ~1 TB | Enlace                             |
| --------- | ----------- | ---------------------------------- |
| rsync.net | 8$          | https://www.rsync.net/pricing.html |
| rsync.net | 12$         |                                    |
| BorgBase  | 6$          | https://www.borgbase.com/          |
| Hetzner   | 2€          |                                    |

### rsync.net

-   snapshots de [ZFS](https://www.rsync.net/resources/howto/snapshots.html).
-   Soporte para append-only de [borg](https://rsync.net/products/borg.html) y [restic](https://rsync.net/products/restic.html)
-   Sin costes de transferencia
-   Coste fijo por TB

### borgbase

-   Panel de control con alertas. APIs
-   Soporte para append-only de borg y restic
-   De Malta con servidores en EU y US
-   Contribuyen al desarrollo de borg
-   12.5$ por 2TB y repositorios ilimitados

### Hetzner Storage Boxes

-   5TB por 11€. tráfico ilimitado.
-   100 subaccounts
-   soporte para muchos protocolos
-   Contribuyen al desarrollo de restic
-   https://docs.hetzner.com/storage/storage-box/access/access-ssh-rsync-borg
-   https://wiki.hetzner.de/index.php/BorgBackup/en
-   https://www.hetzner.com/sb/#drives_size_from=0&drives_size_to=11500&ram_to=64&price_to=290

### Backblaze B2

-   Con restic y el object lock se pueden hacer desarrollar soluciones seguras sin necesidad de append-only
-   https://www.backblaze.com/docs/en/cloud-storage-back-up-linux-to-backblaze-b2?highlight=restic
-   https://www.backblaze.com/docs/en/cloud-storage-integrate-restic-with-backblaze-b2?highlight=restic
-   https://www.backblaze.com/docs/cloud-storage-object-lock
