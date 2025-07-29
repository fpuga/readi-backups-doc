# Métricas para backups

En esta sección se presentan algunas métricas habituales para entender cómo se están comportando nuestras copias e identificar posibles problemas. Llamamos **métricas** a qué medir, y en la sección de [monitorización y alertas](./monitorizacion_alertas.md) hablamos de cómo medirlo.

Un sistema no necesita implementar todas las posibles métricas si no las más apropiadas al caso de uso.

## Tasa de éxito de backups

El porcentaje de backups completados correctamente frente a los intentados. Debería ser del 100%. Cualquier valor inferior requiere atención inmediata. Esta métrica da una visión rápida de la fiabilidad general del sistema.

**Ejemplo en pseudo-código**:

```bash
total_backups=$(grep "backup started" /var/log/backup.log | wc -l)
successful_backups=$(grep "backup completed successfully" /var/log/backup.log | wc -l)
echo "Tasa de éxito: $(($successful_backups * 100 / $total_backups))%"
```

## Tiempo de ejecución del backup

Cuánto tarda en completarse cada proceso de backup. Esta métrica puede alertar sobre degradaciones en el rendimiento o problemas emergentes.

Además permite medir si las copias se completan dentro del tiempo asignado (ventana de backup) sin afectar operaciones normales.

## Tiempo desde el último backup exitoso

Más que una métrica cómo tal se trata de un parámetro crítico de monitorización del sistema.

Si el tiempo transcurrido es mayor al RPO debería lanzarse una alerta.

## Tamaño del backup

Monitorizar el tamaño de los backups ayuda a planificar la capacidad de almacenamiento y puede alertar sobre anomalías. Un incremento o disminución repentino en el tamaño puede indicar que algo no está funcionando correctamente.

## Tasa de crecimiento

Asociado al tamaño del backup, mide la velocidad a la que crece el volumen de backups. Esta métrica ayuda a planificar la capacidad futura de almacenamiento.

**Ejemplo en pseudo-código**:

```text
Tasa de crecimiento = (Volumen actual - Volumen anterior) / Período de tiempo
```

## Uso de recursos durante backups

CPU, memoria, I/O de disco y ancho de banda de red consumidos durante el proceso de backup. Permite minimizar el impacto del backup en el rendimiento de los sistemas.

## Retención efectiva vs. política definida

Compara la retención real con lo establecido en la política.

**Ejemplo en pseudo-código**:

```text
Conformidad de retención = (Backups retenidos correctamente / Total backups) × 100%
```

## Tiempo estimado de restauración

Una métrica predictiva basada en pruebas periódicas que indica cuánto se tarda en recuperar el sistema en caso de necesidad.

Esta métrica permite evaluar si se cumple el RTO.

A veces se expresa cómo el Tiempo medio de restauración (MTTR - Mean Time To Recover):

**Ejemplo en pseudo-código**:

```text
MTTR = Suma de tiempos de restauración / Número de restauraciones
```

## Tasa de verificación

Porcentaje de backups que han sido verificados mediante pruebas de integridad.

**Ejemplo en pseudo-código**:

```text
Tasa de verificación = (Backups verificados / Total backups) × 100%
```

## Tasa de restauración exitosa

Porcentaje de intentos de restauración que funcionan correctamente. Es una métrica importante, ya que mide directamente la eficacia real del sistema de backup.

**Ejemplo en pseudo-código**:

```text
Tasa de restauración = (Restauraciones exitosas / Intentos de restauración) × 100%
```
