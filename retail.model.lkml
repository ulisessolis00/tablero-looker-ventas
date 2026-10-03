connection: "conexion_secreta"
include: "/views/**/*.view.lkml"
include: "/dashboards/*.dashboard.lookml"
include: "/agents/asistente_retail.agent.lkml"
persist_for: "24 hours"

explore: ventas {
  label: "Ventas y rentabilidad"
  description: "Demo con datos ficticios. Importes en MXN sin impuestos."
  join: productos {
    type: left_outer
    sql_on: ${ventas.producto_id} = ${productos.producto_id} ;;
    relationship: many_to_one
  }
  join: clientes {
    type: left_outer
    sql_on: ${ventas.cliente_id} = ${clientes.cliente_id} ;;
    relationship: many_to_one
  }
  join: sucursales {
    type: left_outer
    sql_on: ${ventas.sucursal_id} = ${sucursales.sucursal_id} ;;
    relationship: many_to_one
  }


}
