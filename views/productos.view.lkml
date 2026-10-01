
view: productos {
  sql_table_name: `portafolio_retail.productos` ;;
  dimension: producto_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.producto_id ;;

    link: {
      label: "Ver las ventas de este producto"
      url: "/explore/retail/ventas?fields=ventas.venta_id,ventas.fecha_date,productos.producto,ventas.canal,ventas.estado,ventas.venta_neta&f[productos.producto_id]={{ value | url_encode }}&f[ventas.fecha_date]={{ _filters['ventas.fecha_date'] | default: _filters['ventas.periodo_comparacion'] | url_encode }}&f[ventas.canal]={{ _filters['ventas.canal'] | url_encode }}&f[productos.categoria]={{ _filters['productos.categoria'] | url_encode }}&f[sucursales.zona]={{ _filters['sucursales.zona'] | url_encode }}&f[clientes.segmento]={{ _filters['clientes.segmento'] | url_encode }}&f[productos.producto]={{ _filters['productos.producto'] | url_encode }}&f[sucursales.sucursal]={{ _filters['sucursales.sucursal'] | url_encode }}&sorts=ventas.fecha_date+desc&limit=500"
    }
  }
  dimension: categoria {
    type: string
    sql: ${TABLE}.categoria ;;
  }
  dimension: marca {
    type: string
    sql: ${TABLE}.marca ;;
  }
  dimension: precio_lista {
    type: number
    sql: ${TABLE}.precio_lista ;;
  }
  dimension: producto {
    type: string
    sql: ${TABLE}.producto ;;
  }
  measure: count { type: count drill_fields: [producto_id, categoria, marca, producto] }
}
