view: sucursales {
  sql_table_name: `portafolio_retail.sucursales` ;;
  dimension: sucursal_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.sucursal_id ;;
  }
  dimension: alcaldia {
    type: string
    sql: ${TABLE}.alcaldia ;;
  }
  dimension: sucursal {
    type: string
    sql: ${TABLE}.sucursal ;;
  }
  dimension: zona {
    type: string
    sql: ${TABLE}.zona ;;
  }
  measure: count { type: count drill_fields: [sucursal_id, alcaldia, sucursal, zona] }
}
