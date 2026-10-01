# Ventas y rentabilidad

Este proyecto concentra la operación comercial de una cadena retail en un tablero de Looker. Permite revisar la venta neta, la utilidad bruta, el margen, las ventas completadas y el comportamiento de las devoluciones desde una misma vista.

La información se organiza alrededor de las ventas y se complementa con productos, clientes y sucursales. Con los filtros de periodo, canal, categoría, producto, zona, sucursal y segmento, el tablero permite pasar de una lectura general a un detalle específico sin perder el contexto del negocio.

## Alcance del tablero

El tablero presenta indicadores de desempeño, evolución mensual, participación por canal, comparación entre categorías y equipos de venta, así como tablas para revisar productos y sucursales. Los importes se muestran en MXN sin impuestos.

Las métricas principales son:

- Venta neta
- Utilidad bruta
- Margen bruto
- Ventas completadas
- Importe promedio por venta completada
- Proporción de operaciones devueltas

La utilidad corresponde a utilidad bruta. Es decir, considera venta neta menos costo de venta, sin incluir renta, nómina u otros gastos operativos.

## Datos

El proyecto utiliza datos simulados para representar una operación retail con ventas, productos, clientes y sucursales. La información cubre de enero de 2025 a agosto de 2026 y está almacenada en BigQuery dentro del dataset `portafolio_retail`.

Las tablas utilizadas son:

| Tabla | Contenido |
| --- | --- |
| `ventas` | Operaciones, importes, costos, fechas, canal y estado. |
| `productos` | Producto, marca, categoría y precio de lista. |
| `clientes` | Segmento, rango de edad y fecha de alta. |
| `sucursales` | Sucursal, zona y alcaldía. |

## Modelo y acceso

El modelo principal es `retail` y utiliza la conexión `conexion_secreta`. El Explore `ventas` relaciona las ventas con productos, clientes y sucursales.

El dashboard se encuentra en `dashboards/ventas_rentabilidad.dashboard.lookml`. Las vistas están en la carpeta `views` y el modelo se define en `retail.model.lkml`.

## Agente del dashboard

El tablero incluye el agente `asistente_retail`, definido en `agents/asistente_retail.agent.lkml`. El agente responde en español y utiliza las métricas del modelo para atender preguntas sobre ventas, utilidad, margen, devoluciones, canales, productos, clientes y sucursales.

Sus respuestas indican el periodo y los filtros aplicados. También diferencia la utilidad bruta de otros conceptos de rentabilidad y evita presentar conclusiones que los datos no pueden comprobar.

Para usarlo, el proyecto debe estar desplegado y la instancia de Looker debe tener habilitado Conversational Analytics y Dashboard Agents. El acceso se realiza desde la opción **Chat with this dashboard** dentro del tablero.

## Publicación

Después de cargar los datos y guardar los archivos LookML, valida el proyecto, realiza el commit y despliega los cambios a producción. El dashboard queda disponible desde el modelo `retail`.
