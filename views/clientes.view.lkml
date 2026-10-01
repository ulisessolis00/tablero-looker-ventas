view: clientes {
  sql_table_name: `portafolio_retail.clientes` ;;
  dimension: cliente_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.cliente_id ;;
  }
  dimension: cliente {
    type: string
    sql: ${TABLE}.cliente ;;
  }
  dimension: rango_edad {
    type: string
    sql: ${TABLE}.rango_edad ;;
  }
  dimension: segmento {
    type: string
    sql: ${TABLE}.segmento ;;
  }
  dimension_group: fecha_alta {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    datatype: date
    convert_tz: no
    sql: ${TABLE}.fecha_alta ;;
  }
  measure: count { type: count drill_fields: [cliente_id, cliente, rango_edad, segmento] }
}
