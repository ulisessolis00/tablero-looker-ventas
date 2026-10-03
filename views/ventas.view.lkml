view: ventas {
  sql_table_name: `portafolio_retail.ventas` ;;
  dimension: venta_id { primary_key: yes type: number sql: ${TABLE}.venta_id ;; }
  dimension_group: fecha {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.fecha ;;
  }
  dimension: canal { type: string sql: ${TABLE}.canal ;; }
  dimension: cliente_id { type: number sql: ${TABLE}.cliente_id ;; }
  dimension: producto_id { type: number sql: ${TABLE}.producto_id ;; }
  dimension: sucursal_id { type: number sql: ${TABLE}.sucursal_id ;; }
  dimension: estado { type: string sql: ${TABLE}.estado ;; }
  dimension: unidades { type: number sql: ${TABLE}.unidades ;; }
  dimension: importe_bruto { type: number sql: ${TABLE}.importe_bruto ;; }
  dimension: descuento { type: number sql: ${TABLE}.descuento ;; }
  dimension: venta_neta { type: number sql: ${TABLE}.venta_neta ;; }
  dimension: costo_venta { type: number sql: ${TABLE}.costo_venta ;; }

  set: detalle {
    fields: [venta_id, fecha_date, productos.producto, clientes.cliente,
      sucursales.sucursal, canal, estado, unidades, venta_neta, costo_venta]
  }

  measure: count { type: count drill_fields: [detalle*] }
  measure: operaciones { type: count label: "Operaciones registradas" drill_fields: [detalle*] }
  measure: ventas_completadas {
    type: count
    filters: [estado: "Completada"]
    label: "Ventas completadas"
    drill_fields: [detalle*]
  }
  measure: devoluciones { type: count filters: [estado: "Devuelta"] }
  measure: cancelaciones { type: count filters: [estado: "Cancelada"] }
  measure: ingresos {
    type: sum
    sql: ${venta_neta} ;;
    label: "Venta neta (MXN)"
    value_format: "#,##0.00"
    drill_fields: [detalle*]
  }
  measure: costo {
    type: sum
    sql: ${costo_venta} ;;
    label: "Costo de venta (MXN)"
    value_format: "#,##0.00"
  }
  measure: utilidad {
    type: number
    sql: ${ingresos} - ${costo} ;;
    label: "Utilidad bruta (MXN)"
    value_format: "#,##0.00"
  }
  measure: margen {
    type: number
    sql: SAFE_DIVIDE(${utilidad}, ${ingresos}) ;;
    label: "Margen bruto"
    value_format: "0.0%"
    html:
      {% if value == nil %}
        <span style="color: #8B9AAF;">—</span>
      {% elsif value >= 0.30 %}
        <span style="display: inline-block; padding: 3px 7px; border-radius: 5px; background-color: #DCE1FF; color: #353B86; font-weight: 600;">{{ rendered_value }}</span>
      {% elsif value >= 0.20 %}
        <span style="display: inline-block; padding: 3px 7px; border-radius: 5px; background-color: #F0F2FC; color: #353B86; font-weight: 600;">{{ rendered_value }}</span>
      {% else %}
        <span style="display: inline-block; padding: 3px 7px; border-radius: 5px; background-color: #F1F5F9; color: #64748B; font-weight: 600;">{{ rendered_value }}</span>
      {% endif %} ;;
  }
  measure: venta_promedio {
    type: number
    sql: SAFE_DIVIDE(${ingresos}, ${ventas_completadas}) ;;
    label: "Importe por venta completada (MXN)"
    value_format: "#,##0.00"
  }
  measure: tasa_devolucion {
    type: number
    sql: SAFE_DIVIDE(${devoluciones}, ${operaciones}) ;;
    label: "Tasa de devolución"
    value_format: "0.0%"
  }
  measure: clientes_compradores {
    type: count_distinct
    sql: ${cliente_id} ;;
    filters: [estado: "Completada"]
    label: "Clientes compradores"
  }

  # LIQUID 1. El selector cambia la cuenta, sin duplicar la gráfica.
  # Todas las opciones están en MXN para mantener unidades consistentes.
  parameter: metrica {
    type: unquoted
    label: "Métrica para explorar"
    default_value: "ingresos"
    allowed_value: { label: "Venta neta (MXN)" value: "ingresos" }
    allowed_value: { label: "Utilidad bruta (MXN)" value: "utilidad" }
    allowed_value: { label: "Importe por venta completada (MXN)" value: "promedio" }
  }
  measure: metrica_dinamica {
    type: number
    label_from_parameter: metrica
    value_format: "#,##0.00"
    sql:
      {% if metrica._parameter_value == 'utilidad' %}
        ${utilidad}
      {% elsif metrica._parameter_value == 'promedio' %}
        ${venta_promedio}
      {% else %}
        ${ingresos}
      {% endif %} ;;
  }

  parameter: granularidad {
    type: unquoted
    label: "Agrupar fechas por"
    default_value: "mes"
    allowed_value: { label: "Día" value: "dia" }
    allowed_value: { label: "Semana (lunes)" value: "semana" }
    allowed_value: { label: "Mes" value: "mes" }
    allowed_value: { label: "Trimestre" value: "trimestre" }
  }
  dimension: fecha_dinamica {
    type: date
    datatype: date
    convert_tz: no
    label_from_parameter: granularidad
    sql:
      {% if granularidad._parameter_value == 'dia' %}
        ${TABLE}.fecha
      {% elsif granularidad._parameter_value == 'semana' %}
        DATE_TRUNC(${TABLE}.fecha, WEEK(MONDAY))
      {% elsif granularidad._parameter_value == 'trimestre' %}
        DATE_TRUNC(${TABLE}.fecha, QUARTER)
      {% else %}
        DATE_TRUNC(${TABLE}.fecha, MONTH)
      {% endif %} ;;
  }

  parameter: desglose {
    type: unquoted
    label: "Desglosar por"
    default_value: "categoria"
    allowed_value: { label: "Categoría" value: "categoria" }
    allowed_value: { label: "Canal" value: "canal" }
    allowed_value: { label: "Zona" value: "zona" }
    allowed_value: { label: "Segmento de cliente" value: "segmento" }
  }
  dimension: desglose_dinamico {
    type: string
    label_from_parameter: desglose
    sql:
      {% if desglose._parameter_value == 'canal' %}
        ${canal}
      {% elsif desglose._parameter_value == 'zona' %}
        ${sucursales.zona}
      {% elsif desglose._parameter_value == 'segmento' %}
        ${clientes.segmento}
      {% else %}
        ${productos.categoria}
      {% endif %} ;;
  }


  filter: periodo_comparacion {
    type: date
    datatype: date
    label: "Periodo para comparar (rango cerrado)"
    description: "Usa inicio y fin dentro de enero-agosto de 2026. No agregues fecha_date a la misma consulta comparativa."
  }
  dimension: en_periodo_actual {
    hidden: yes
    type: yesno
    sql: {% condition periodo_comparacion %} ${TABLE}.fecha {% endcondition %} ;;
  }
  dimension: en_periodo_anterior {
    hidden: yes
    type: yesno
    # Desplazamos las fechas de 2025 un año para probarlas contra el rango de 2026.
    sql: {% condition periodo_comparacion %} DATE_ADD(${TABLE}.fecha, INTERVAL 1 YEAR) {% endcondition %} ;;
  }
  dimension: comparacion_valida {
    hidden: yes
    type: yesno
    sql:
      COALESCE(
        CAST({% date_start periodo_comparacion %} AS DATE) >= DATE '2026-01-01'
        AND CAST({% date_end periodo_comparacion %} AS DATE) <= DATE '2026-09-01'
        AND CAST({% date_start periodo_comparacion %} AS DATE)
            < CAST({% date_end periodo_comparacion %} AS DATE), FALSE) ;;
  }
  measure: ingresos_actual_base {
    hidden: yes
    type: sum
    sql: CASE WHEN ${en_periodo_actual} THEN ${venta_neta} ELSE 0 END ;;
  }
  measure: costo_actual_base {
    hidden: yes
    type: sum
    sql: CASE WHEN ${en_periodo_actual} THEN ${costo_venta} ELSE 0 END ;;
  }
  measure: completadas_actual_base {
    hidden: yes
    type: count_distinct
    sql: CASE WHEN ${en_periodo_actual} AND ${estado} = 'Completada' THEN ${venta_id} END ;;
  }
  measure: registros_actual_base {
    hidden: yes
    type: count_distinct
    sql: CASE WHEN ${en_periodo_actual} THEN ${venta_id} END ;;
  }
  measure: metrica_actual_base {
    hidden: yes
    type: number
    sql:
      {% if metrica._parameter_value == 'utilidad' %}
        ${ingresos_actual_base} - ${costo_actual_base}
      {% elsif metrica._parameter_value == 'promedio' %}
        SAFE_DIVIDE(${ingresos_actual_base}, ${completadas_actual_base})
      {% else %}
        ${ingresos_actual_base}
      {% endif %} ;;
  }
  measure: valor_actual {
    type: number
    label: "Periodo seleccionado (MXN)"
    value_format: "#,##0.00"
    sql: CASE WHEN ${comparacion_valida} AND ${registros_actual_base} > 0
      THEN ${metrica_actual_base} ELSE NULL END ;;
  }
  measure: ingresos_anterior_base {
    hidden: yes
    type: sum
    sql: CASE WHEN ${en_periodo_anterior} THEN ${venta_neta} ELSE 0 END ;;
  }
  measure: costo_anterior_base {
    hidden: yes
    type: sum
    sql: CASE WHEN ${en_periodo_anterior} THEN ${costo_venta} ELSE 0 END ;;
  }
  measure: completadas_anterior_base {
    hidden: yes
    type: count_distinct
    sql: CASE WHEN ${en_periodo_anterior} AND ${estado} = 'Completada' THEN ${venta_id} END ;;
  }
  measure: registros_anterior_base {
    hidden: yes
    type: count_distinct
    sql: CASE WHEN ${en_periodo_anterior} THEN ${venta_id} END ;;
  }
  measure: metrica_anterior_base {
    hidden: yes
    type: number
    sql:
      {% if metrica._parameter_value == 'utilidad' %}
        ${ingresos_anterior_base} - ${costo_anterior_base}
      {% elsif metrica._parameter_value == 'promedio' %}
        SAFE_DIVIDE(${ingresos_anterior_base}, ${completadas_anterior_base})
      {% else %}
        ${ingresos_anterior_base}
      {% endif %} ;;
  }
  measure: valor_anterior {
    type: number
    label: "Mismas fechas, año anterior (MXN)"
    value_format: "#,##0.00"
    sql: CASE WHEN ${comparacion_valida} AND ${registros_anterior_base} > 0
      THEN ${metrica_anterior_base} ELSE NULL END ;;
  }

  measure: diferencia_interanual {
    type: number
    label: "Diferencia interanual (MXN)"
    value_format: "#,##0.00"
    sql: ${valor_actual} - ${valor_anterior} ;;
  }
  measure: variacion_interanual {
    type: number
    label: "Variación interanual"
    value_format: "0.0%"
    # Una base negativa o cero no se presta a esta lectura de crecimiento.
    sql: CASE WHEN ${valor_anterior} > 0
      THEN SAFE_DIVIDE(${valor_actual} - ${valor_anterior}, ${valor_anterior})
      ELSE NULL END ;;
    html:
      {% if value == nil %}
        <span style="color: #64748B;">—</span>
      {% elsif value > 0 %}
        <span style="color: #087F8C; font-weight: 600; font-variant: tabular-nums;">↑ {{ rendered_value }}</span>
      {% elsif value < 0 %}
        <span style="color: #B84A62; font-weight: 600; font-variant: tabular-nums;">↓ {{ rendered_value }}</span>
      {% else %}
        <span style="color: #64748B;">{{ rendered_value }}</span>
      {% endif %} ;;
  }

  measure: margen_grafico {
    type: number
    label: "Margen bruto"
    value_format: "0.0%"
    sql: ${margen} ;;
  }
  measure: tasa_cancelacion {
    type: number
    label: "Operaciones canceladas / registradas"
    value_format: "0.0%"
    sql: SAFE_DIVIDE(${cancelaciones}, ${operaciones}) ;;
  }

  parameter: ancho_intervalo {
    type: unquoted
    label: "Ancho de intervalo (MXN)"
    default_value: "1000"
    allowed_value: { label: "500 MXN" value: "500" }
    allowed_value: { label: "1,000 MXN" value: "1000" }
    allowed_value: { label: "2,000 MXN" value: "2000" }
  }
  dimension: intervalo_importe {
    type: number
    label: "Inicio del intervalo (MXN)"
    value_format: "#,##0"
    sql: FLOOR(${venta_neta} / {% parameter ancho_intervalo %})
      * {% parameter ancho_intervalo %} ;;
    description: "Límite inferior incluido. El superior es este valor más el ancho elegido y se excluye. Solo ventas completadas en el histograma."
  }

  dimension: fecha_comparable_base {
    hidden: yes
    type: date
    datatype: date
    convert_tz: no
    sql: CASE
      WHEN ${en_periodo_actual} THEN ${TABLE}.fecha
      WHEN ${en_periodo_anterior} THEN DATE_ADD(${TABLE}.fecha, INTERVAL 1 YEAR)
      ELSE NULL END ;;
  }
  dimension: fecha_comparable {
    type: date
    datatype: date
    convert_tz: no
    label: "Fecha alineada al periodo seleccionado"
    sql:
      {% if granularidad._parameter_value == 'dia' %}
        ${fecha_comparable_base}
      {% elsif granularidad._parameter_value == 'semana' %}
        DATE_TRUNC(${fecha_comparable_base}, WEEK(MONDAY))
      {% elsif granularidad._parameter_value == 'trimestre' %}
        DATE_TRUNC(${fecha_comparable_base}, QUARTER)
      {% else %}
        DATE_TRUNC(${fecha_comparable_base}, MONTH)
      {% endif %} ;;
  }

  # Formato de los indicadores del dashboard.
  measure: ingresos_kpi {
    hidden: yes
    type: number
    label: "Venta neta · MXN"
    value_format: "#,##0"
    sql: ${ingresos} ;;
    drill_fields: [detalle*]
    html:
      {% if value == nil %}
        <span style="color: #8B9AAF;">—</span>
      {% else %}
        <span style="color: #172B4D; font-weight: 700; letter-spacing: -0.03em; line-height: 1.15;">{{ rendered_value }}</span>
      {% endif %} ;;
  }

  measure: utilidad_kpi {
    hidden: yes
    type: number
    label: "Utilidad bruta · MXN"
    value_format: "#,##0"
    sql: ${utilidad} ;;
    drill_fields: [detalle*]
    html:
      {% if value == nil %}
        <span style="color: #8B9AAF;">—</span>
      {% else %}
        <span style="color: #087F8C; font-weight: 700; letter-spacing: -0.03em; line-height: 1.15;">{{ rendered_value }}</span>
      {% endif %} ;;
  }

  measure: margen_kpi {
    hidden: yes
    type: number
    label: "Margen bruto"
    value_format: "0.0%"
    sql: ${margen} ;;
    drill_fields: [detalle*]
    html:
      {% if value == nil %}
        <span style="color: #8B9AAF;">—</span>
      {% else %}
        <span style="color: #5B5FEF; font-weight: 700; letter-spacing: -0.03em; line-height: 1.15;">{{ rendered_value }}</span>
      {% endif %} ;;
  }

  measure: ventas_completadas_kpi {
    hidden: yes
    type: number
    label: "Ventas completadas"
    value_format: "#,##0"
    sql: ${ventas_completadas} ;;
    drill_fields: [detalle*]
    html:
      {% if value == nil %}
        <span style="color: #8B9AAF;">—</span>
      {% else %}
        <span style="color: #172B4D; font-weight: 700; letter-spacing: -0.03em; line-height: 1.15;">{{ rendered_value }}</span>
      {% endif %} ;;
  }

  measure: valor_actual_kpi {
    hidden: yes
    type: number
    label: "Periodo actual · MXN"
    value_format: "#,##0"
    sql: ${valor_actual} ;;
    html:
      {% if value == nil %}
        <span style="color: #8B9AAF;">—</span>
      {% else %}
        <span style="color: #5B5FEF; font-weight: 700; letter-spacing: -0.03em; line-height: 1.15;">{{ rendered_value }}</span>
      {% endif %} ;;
  }

  measure: valor_anterior_kpi {
    hidden: yes
    type: number
    label: "Año anterior · MXN"
    value_format: "#,##0"
    sql: ${valor_anterior} ;;
    html:
      {% if value == nil %}
        <span style="color: #8B9AAF;">—</span>
      {% else %}
        <span style="color: #64748B; font-weight: 700; letter-spacing: -0.03em; line-height: 1.15;">{{ rendered_value }}</span>
      {% endif %} ;;
  }

  measure: diferencia_interanual_kpi {
    hidden: yes
    type: number
    label: "Diferencia interanual · MXN"
    value_format: "#,##0"
    sql: ${diferencia_interanual} ;;
    html:
      {% if value == nil %}
        <span style="color: #8B9AAF;">—</span>
      {% else %}
        <span style="color: #172B4D; font-weight: 700; letter-spacing: -0.03em; line-height: 1.15;">{{ rendered_value }}</span>
      {% endif %} ;;
  }

  measure: variacion_interanual_kpi {
    hidden: yes
    type: number
    label: "Variación interanual"
    value_format: "+0.0%;-0.0%;0.0%"
    sql: ${variacion_interanual} ;;
    html:
      {% if value == nil %}
        <span style="color: #8B9AAF;">—</span>
      {% elsif value > 0 %}
        <span style="display: inline-block; padding: 6px 10px; border: 1px solid #C7E4E6; border-radius: 8px; background-color: #EAF5F5; color: #087F8C; font-weight: 700; letter-spacing: -0.03em; line-height: 1.15;">{{ rendered_value }}</span>
      {% elsif value < 0 %}
        <span style="display: inline-block; padding: 6px 10px; border: 1px solid #ECCDD5; border-radius: 8px; background-color: #FBF0F3; color: #B84A62; font-weight: 700; letter-spacing: -0.03em; line-height: 1.15;">{{ rendered_value }}</span>
      {% else %}
        <span style="color: #64748B; font-weight: 700;">{{ rendered_value }}</span>
      {% endif %} ;;
  }

  measure: clientes_compradores_kpi {
    hidden: yes
    type: number
    label: "Clientes compradores"
    value_format: "#,##0"
    sql: ${clientes_compradores} ;;
    drill_fields: [detalle*]
    html:
      {% if value == nil %}
        <span style="color: #8B9AAF;">—</span>
      {% else %}
        <span style="color: #172B4D; font-weight: 700; letter-spacing: -0.03em; line-height: 1.15;">{{ rendered_value }}</span>
      {% endif %} ;;
  }

  measure: venta_promedio_kpi {
    hidden: yes
    type: number
    label: "Ticket promedio · MXN"
    value_format: "#,##0"
    sql: ${venta_promedio} ;;
    drill_fields: [detalle*]
    html:
      {% if value == nil %}
        <span style="color: #8B9AAF;">—</span>
      {% else %}
        <span style="color: #172B4D; font-weight: 700; letter-spacing: -0.03em; line-height: 1.15;">{{ rendered_value }}</span>
      {% endif %} ;;
  }

  measure: tasa_devolucion_kpi {
    hidden: yes
    type: number
    label: "Tasa de devolución"
    value_format: "0.0%"
    sql: ${tasa_devolucion} ;;
    drill_fields: [detalle*]
    html:
      {% if value == nil %}
        <span style="color: #8B9AAF;">—</span>
      {% else %}
        <span style="color: #B87928; font-weight: 700; letter-spacing: -0.03em; line-height: 1.15;">{{ rendered_value }}</span>
      {% endif %} ;;
  }

  measure: importe_minimo_completado {
    type: min
    group_label: "Distribución de importes"
    label: "Importe mínimo · MXN"
    sql: ${venta_neta} ;;
    filters: [estado: "Completada"]
    value_format: "#,##0.00"
  }

  measure: importe_p25_completado {
    type: percentile
    percentile: 25
    group_label: "Distribución de importes"
    label: "Percentil 25 del importe · MXN"
    sql: ${venta_neta} ;;
    filters: [estado: "Completada"]
    value_format: "#,##0.00"
  }

  measure: importe_mediano_completado {
    type: median
    group_label: "Distribución de importes"
    label: "Mediana del importe · MXN"
    sql: ${venta_neta} ;;
    filters: [estado: "Completada"]
    value_format: "#,##0.00"
  }

  measure: importe_p75_completado {
    type: percentile
    percentile: 75
    group_label: "Distribución de importes"
    label: "Percentil 75 del importe · MXN"
    sql: ${venta_neta} ;;
    filters: [estado: "Completada"]
    value_format: "#,##0.00"
  }

  measure: importe_maximo_completado {
    type: max
    group_label: "Distribución de importes"
    label: "Importe máximo · MXN"
    sql: ${venta_neta} ;;
    filters: [estado: "Completada"]
    value_format: "#,##0.00"
  }
}
