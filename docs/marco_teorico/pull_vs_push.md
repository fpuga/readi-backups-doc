# Modelos de transferencia: Pull vs Push

## Conceptos fundamentales

Existen dos modelos principales para transferir los datos desde el origen hasta el sistema de almacenamiento de las copias:

**Pull**: El sistema de backup es quien inicia y controla el proceso de copia, "extrayendo" los datos desde los servidores de origen. En este modelo, el sistema de backup actúa como cliente y los servidores de origen como servidores de los datos.

**Push**: Los servidores de origen son los que inician y controlan el proceso, "enviando" sus datos hacia el sistema de backup. En este modelo, los servidores de origen actúan como clientes y el sistema de backup como servidor receptor de datos.

## Modelo Pull

**Ventajas:**

-   **Control centralizado**: Todas las operaciones de backup se gestionan desde un único punto, facilitando la programación y supervisión.
-   **Mejor visibilidad**: Es más fácil verificar qué servidores han sido respaldados correctamente y cuáles no.
-   **Menor configuración en servidores**: Los servidores de origen requieren configuración mínima, principalmente permisos de acceso para el servidor de backup.
-   **Recuperación ante fallos**: Si un servidor de origen falla antes de iniciar su backup, el sistema central aún puede intentarlo posteriormente.

**Desventajas:**

-   **Superficie de ataque ampliada**: El servidor de backup necesita credenciales para acceder a todos los servidores, convirtiéndose en un objetivo crítico si es comprometido.
-   **Requisitos de conectividad**: El servidor de backup debe tener acceso de red a todos los servidores de origen.
-   **Posible sobrecarga**: El servidor de backup puede convertirse en cuello de botella al gestionar muchos backups simultáneos.
-   **Configuración de firewall**: Requiere apertura de puertos entrantes en los servidores de origen o configuraciones de VPN.

**Riesgos de seguridad:**

-   **Credenciales centralizadas**: El sistema de backup dispone de credenciales para acceder a todos los servidores, convirtiéndose en un punto crítico.
-   **Vector de propagación lateral**: Un sistema de backup comprometido podría utilizarse para acceder lateralmente a otros sistemas.

## Modelo Push

**Ventajas:**

-   **Mayor seguridad**: Los servidores de origen no necesitan permitir conexiones entrantes del sistema de backup.
-   **Mejor adaptación a redes segmentadas**: Funciona bien cuando los servidores están en redes distintas o protegidos por firewalls estrictos.
-   **Distribución de carga**: El procesamiento se distribuye entre todos los servidores de origen.
-   **Flexibilidad en la programación**: Cada servidor puede iniciar su backup en el momento más adecuado según su carga de trabajo.

**Desventajas:**

-   **Gestión distribuida**: La configuración y supervisión están distribuidas, complicando la administración.
-   **Dependencia del servidor de origen**: Si el servidor sufre un compromiso severo, el atacante podría también afectar al proceso de backup.
-   **Dificultad para verificar completitud**: Es más complejo determinar si todos los servidores han realizado correctamente sus backups.
-   **Configuración más compleja**: Cada servidor debe configurarse individualmente.

**Riesgos de seguridad:**

-   **Autenticación del receptor**: Es crucial verificar que los datos se envían al sistema de backup legítimo (certificados, verificación de claves).
-   **Denegación de servicio**: Un servidor comprometido podría saturar el sistema de backup con datos fraudulentos.

## Modelos híbridos y avanzados

### Servidor intermediario

Este enfoque utiliza un servidor intermedio que actúa como puente entre los servidores de origen y el sistema de backup:

1. Los servidores de origen envían (push) sus datos al servidor intermediario.
2. El sistema de backup extrae (pull) los datos desde el servidor intermediario.

**Ventajas:**

-   **Aislamiento de seguridad**: El sistema de backup final no necesita acceso directo a los servidores productivos.
-   **Optimización de red**: El servidor intermediario puede ubicarse estratégicamente para optimizar el tráfico.
-   **Procesamiento adicional**: El servidor intermediario puede realizar compresión, cifrado o verificación antes de la transferencia final.
-   **Flexibilidad horaria**: Los servidores pueden enviar backups a su conveniencia, y el sistema central los recoge posteriormente.

**Desventajas:**

-   **Mayor complejidad y Punto adicional de fallo**: Introduce otro componente que debe mantenerse y monitorizarse.
-   **Requisitos de almacenamiento intermedio**: El servidor proxy necesita espacio suficiente para almacenar temporalmente todos los backups.
-   **Latencia adicional**: El proceso requiere dos transferencias en lugar de una.

### Push-Only-Append (Envío con solo adición)

Este modelo se enfoca en la seguridad permitiendo a los servidores de origen únicamente añadir datos al sistema de backup, sin capacidad para modificar o eliminar backups anteriores:

**Ventajas:**

-   **Protección contra ransomware**: Un servidor comprometido no puede eliminar o sobreescribir backups históricos.
-   **Inmutabilidad de datos**: Los backups antiguos permanecen inalterables, proporcionando una línea de tiempo confiable.
-   **Simplificación de permisos**: Los servidores solo necesitan permisos para escribir, no para leer ni modificar datos existentes.

**Desventajas:**

-   La principal ventaja es la necesidad de una herramienta que soporte este modelo y que resta flexibilidad para implementar distintas características
