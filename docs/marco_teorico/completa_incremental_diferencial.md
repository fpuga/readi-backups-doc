# Completo / Incremental / Diferencial

Los backups se pueden categorizar de muchas formas entre ellas si son completos o incrementales.

## Completo (Full)

Copia total de los datos seleccionados

-   Ventajas: Recuperación simple y rápida
-   Desventajas: Mayor espacio de almacenamiento y tiempo de ejecución
-   Ideal para:
    -   Servidores pequeños con datos críticos
    -   Entornos donde el espacio de almacenamiento o el ancho de banda no es una limitación
    -   Servidores de configuración
    -   Sistemas que requieren restauración rápida
    -   Cuando existe la necesidad frecuente de recuperar ficheros específicos en momentos concretos
    -   Cuando se quiere reducir al máximo la complejidad del sistema, a cambio de aumentar el coste

## Incremental (Incremental)

Copia solo los cambios desde el último backup (completo o incremental)

-   Ventajas: Rápido, menor espacio
-   Desventajas: Restauración más compleja, dependencia de la cadena de backups
-   Ideal para:
    -   Grandes volúmenes de datos con cambios frecuentes
    -   Se quiere mantener al mínimo el espacio en disco y el consumo de red
    -   Entornos con ventanas de backup reducidas
    -   Permiten incrementar granularidad (RPO) sin incrementar costes

## Diferencial (Differential)

Copia los cambios desde el último backup completo

-   Ventajas: Restauración más sencilla que incremental
-   Desventajas: Ocupa más espacio que incremental
-   Ideal para:
    -   Situaciones intermedias que requieren equilibrio entre espacio y tiempo de restauración
    -   Sistemas donde es aceptable un tiempo de recuperación moderado pero se quiere reducir el riesgo de backups corruptos

## Comparativa de tipos básicos de backup

| Característica                   | Completo                         | Incremental                                       | Diferencial                                |
| -------------------------------- | -------------------------------- | ------------------------------------------------- | ------------------------------------------ |
| **Velocidad de backup**          | Lenta                            | Muy rápida                                        | Rápida (se ralentiza con el tiempo)        |
| **Velocidad de restore**         | Muy rápida                       | Lenta (requiere full + todas las incrementales)   | Media (requiere full + última diferencial) |
| **Ancho de banda**               | Alto                             | Muy bajo                                          | Medio (aumenta con el tiempo)              |
| **Espacio en disco**             | Muy alto                         | Mínimo                                            | Medio (crece con el tiempo)                |
| **Riesgo de restore incorrecto** | Bajo                             | Alto (fallo en cualquier incremental afecta todo) | Medio (solo dos puntos de fallo)           |
| **Escenario ideal**              | Datos críticos con pocos cambios | Entornos con ancho de banda limitado              | Balance entre espacio y confiabilidad      |
| **Coste de implementación**      | Simple                           | Complejo                                          | Moderado                                   |

## Mirror backup

La definición de "mirror backup" [varía según la fuente](https://www.nakivo.com/blog/backup-types-explained/). Lo más habitual es entenderla cómo

> una copia exacta del conjunto de datos original, pero solo se almacena la versión más reciente, sin conservar versiones anteriores. Se llama "espejo" porque refleja exactamente el estado actual de los datos originales. Todos los archivos se almacenan de forma individual, igual que en el sistema de origen.

-   Recuperación rápida: puedes restaurar archivos sin complicaciones.
-   Acceso directo a los archivos respaldados individualmente.
-   Ocupa mucho espacio.
-   Si los datos originales se dañan o se eliminan, el daño también afecta al backup.

Un tipo específico de copia espejo son ciertos modos de RAID. Los datos se replican en dos (o más) discos en el propio servidor. En caso de que un disco falle el otro seguirá funcionando y la monitorización nos avisará de la necesidad de cambiarlo.

Merece la pena mencionar este sistema, pero entraría más en el ámbito de la alta disponibilidad que en el de las copias de seguridad.

## Variantes avanzadas

Existen variantes más sofisticadas de estas estrategias básicas:

-   **Synthetic Full Backup**: Crea un nuevo backup completo (en el destino) combinando el último full con los incrementales, sin necesidad de transferir todos los datos desde la fuente. Ahorra ancho de banda pero no espacio de almacenamiento. Puede mejorar el tiempo de restauración.

-   **Progressive Incremental (Incremental-Forever)**: Solo se realiza un backup completo inicial, seguido de incrementales indefinidamente.

-   **Reverse Incremental**: Cada incremental se aplica inmediatamente al backup completo, creando un nuevo completo actualizado, mientras conserva los incrementales para poder retroceder a estados anteriores. Requiere de herramientas más complejas pero disminuye el problema del tiempo de restauración de los sistemas incrementales.

-   **Forever Forward Incremental**: Similar al incremental-forever, pero mantiene solo una generación de backup en el servidor, renovando periódicamente el backup completo mediante la fusión de incrementales.
