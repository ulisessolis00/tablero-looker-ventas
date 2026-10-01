- dashboard: ventas_rentabilidad
  title: Ventas y rentabilidad
  default_dashboard_agent: asistente_retail
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: false
  filters_bar_collapsed: false
  filters_location_top: true
  auto_run: false

  filters:
    - name: Periodo
      title: Periodo
      type: field_filter
      default_value: 2026/01/01 for 8 months
      allow_multiple_values: false
      required: true
      model: retail
      explore: ventas
      field: ventas.fecha_date
    - name: Canal
      title: Canal
      type: field_filter
      default_value: ''
      allow_multiple_values: true
      required: false
      model: retail
      explore: ventas
      field: ventas.canal
    - name: Categoria
      title: Categoría
      type: field_filter
      default_value: ''
      allow_multiple_values: true
      required: false
      model: retail
      explore: ventas
      field: productos.categoria
    - name: Producto
      title: Producto
      type: field_filter
      default_value: ''
      allow_multiple_values: true
      required: false
      model: retail
      explore: ventas
      field: productos.producto
      listens_to_filters:
        - Categoria
    - name: Zona
      title: Zona
      type: field_filter
      default_value: ''
      allow_multiple_values: true
      required: false
      model: retail
      explore: ventas
      field: sucursales.zona
    - name: Sucursal
      title: Sucursal
      type: field_filter
      default_value: ''
      allow_multiple_values: true
      required: false
      model: retail
      explore: ventas
      field: sucursales.sucursal
      listens_to_filters:
        - Zona
    - name: Segmento
      title: Segmento
      type: field_filter
      default_value: ''
      allow_multiple_values: true
      required: false
      model: retail
      explore: ventas
      field: clientes.segmento
    - name: Metrica
      title: Indicador · MXN
      type: field_filter
      default_value: ingresos
      allow_multiple_values: false
      required: true
      model: retail
      explore: ventas
      field: ventas.metrica
      ui_config:
        type: dropdown_menu
        display: inline
    - name: Granularidad
      title: Frecuencia
      type: field_filter
      default_value: mes
      allow_multiple_values: false
      required: true
      model: retail
      explore: ventas
      field: ventas.granularidad
      ui_config:
        type: dropdown_menu
        display: inline
    - name: Desglose
      title: Desglose
      type: field_filter
      default_value: canal
      allow_multiple_values: false
      required: true
      model: retail
      explore: ventas
      field: ventas.desglose
      ui_config:
        type: dropdown_menu
        display: inline
    - name: Intervalo
      title: Intervalo · MXN
      type: field_filter
      default_value: '1000'
      allow_multiple_values: false
      required: true
      model: retail
      explore: ventas
      field: ventas.ancho_intervalo
      ui_config:
        type: dropdown_menu
        display: inline
  elements:
    - name: titulo_resumen
      type: text
      body_text: |-
        <div style="padding:12px 18px;border-radius:16px;background-color:#0F141B;background-image:linear-gradient(135deg,#0B0E11 0%,#142135 60%,#0B0E11 100%);border:1px solid rgba(234,236,239,0.10);box-shadow:0 3px 10px rgba(23,43,77,0.10);">
          <h2 style="color:#EAECEF;font-family:Arial,sans-serif;font-weight:800;font-size:20px;line-height:24px;letter-spacing:0.2px;margin:0;">Resumen comercial</h2>
          <div style="margin-top:8px;height:4px;width:64px;background-color:#8D91FF;border-radius:999px;"></div>
        </div>
      row: 0
      col: 0
      width: 24
      height: 2
    - name: ingresos
      title: Venta neta · MXN
      type: single_value
      model: retail
      explore: ventas
      fields:
        - ventas.ingresos_kpi
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 2
      col: 0
      width: 6
      height: 3
      limit: 500
      custom_color_enabled: true
      custom_color: '#172B4D'
      show_single_value_title: true
      show_comparison: false
      single_value_title: Venta neta · MXN
    - name: utilidad
      title: Utilidad bruta · MXN
      type: single_value
      model: retail
      explore: ventas
      fields:
        - ventas.utilidad_kpi
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 2
      col: 6
      width: 6
      height: 3
      limit: 500
      custom_color_enabled: true
      custom_color: '#087F8C'
      show_single_value_title: true
      show_comparison: false
      single_value_title: Utilidad bruta · MXN
    - name: margen
      title: Margen bruto
      type: single_value
      model: retail
      explore: ventas
      fields:
        - ventas.margen_kpi
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 2
      col: 12
      width: 6
      height: 3
      limit: 500
      custom_color_enabled: true
      custom_color: '#5B5FEF'
      show_single_value_title: true
      show_comparison: false
      single_value_title: Margen bruto
    - name: ventas_completadas
      title: Ventas completadas
      type: single_value
      model: retail
      explore: ventas
      fields:
        - ventas.ventas_completadas_kpi
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 2
      col: 18
      width: 6
      height: 3
      limit: 500
      custom_color_enabled: true
      custom_color: '#172B4D'
      show_single_value_title: true
      show_comparison: false
      single_value_title: Ventas completadas
    - name: titulo_evolucion
      type: text
      body_text: |-
        <div style="padding:12px 18px;border-radius:16px;background-color:#0F141B;background-image:linear-gradient(135deg,#0B0E11 0%,#142135 60%,#0B0E11 100%);border:1px solid rgba(234,236,239,0.10);box-shadow:0 3px 10px rgba(23,43,77,0.10);">
          <h2 style="color:#EAECEF;font-family:Arial,sans-serif;font-weight:800;font-size:20px;line-height:24px;letter-spacing:0.2px;margin:0;">Evolución de ventas</h2>
          <div style="margin-top:8px;height:4px;width:64px;background-color:#8D91FF;border-radius:999px;"></div>
        </div>
      row: 5
      col: 0
      width: 24
      height: 2
    - name: lineas_dinamicas
      title: Evolución del indicador por desglose · MXN
      type: looker_line
      model: retail
      explore: ventas
      fields:
        - ventas.fecha_dinamica
        - ventas.desglose_dinamico
        - ventas.metrica_dinamica
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
        Metrica: ventas.metrica
        Granularidad: ventas.granularidad
        Desglose: ventas.desglose
      row: 7
      col: 0
      width: 14
      height: 8
      limit: 5000
      sorts:
        - ventas.fecha_dinamica
        - ventas.desglose_dinamico
      pivots:
        - ventas.desglose_dinamico
      colors: &id001
        - '#5B5FEF'
        - '#087F8C'
        - '#4A78A8'
        - '#B87928'
      show_view_names: false
      show_x_axis_label: false
      show_y_axis_labels: false
      legend_position: left
      hide_legend: false
      show_null_points: false
      discontinuous_nulls: true
      point_style: none
      interpolation: linear
      x_axis_scale: time
      series_colors:
        App: '#4A78A8'
        Tienda: '#5B5FEF'
        Web: '#087F8C'
        Deportes: '#4A78A8'
        Hogar: '#087F8C'
        Papelería: '#B87928'
        Tecnología: '#5B5FEF'
        Centro: '#5B5FEF'
        Norte: '#4A78A8'
        Oriente: '#B87928'
        Sur: '#087F8C'
        Individual: '#5B5FEF'
        Negocio: '#087F8C'
      stacking: ''
      show_value_labels: false
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_x_axis_ticks: true
      show_y_axis_ticks: true
      font_size: 12px
      advanced_vis_config: |-
        {"chart":{"backgroundColor":"#FFFFFF","style":{"fontFamily":"Arial, sans-serif"}},"legend":{"itemStyle":{"color":"#334155","fontSize":"12px","fontWeight":"normal"},"itemHoverStyle":{"color":"#172B4D"},"symbolRadius":4},"xAxis":{"lineColor":"#D9E1EC","tickColor":"#D9E1EC","labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"yAxis":{"gridLineColor":"#E8EDF4","gridLineWidth":1,"labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"tooltip":{"backgroundColor":"#172B4D","borderColor":"#172B4D","borderRadius":8,"shadow":false,"style":{"color":"#FFFFFF","fontSize":"12px"}},"plotOptions":{"series":{"animation":false,"lineWidth":2.5,"marker":{"enabled":false}}}}
    - name: lineas_venta_utilidad
      title: Venta neta y utilidad bruta · MXN
      type: looker_line
      model: retail
      explore: ventas
      fields:
        - ventas.fecha_dinamica
        - ventas.ingresos
        - ventas.utilidad
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
        Granularidad: ventas.granularidad
      row: 7
      col: 14
      width: 10
      height: 8
      limit: 5000
      sorts:
        - ventas.fecha_dinamica
      colors: *id001
      show_view_names: false
      show_x_axis_label: false
      show_y_axis_labels: false
      legend_position: left
      hide_legend: false
      show_null_points: false
      discontinuous_nulls: true
      point_style: none
      interpolation: linear
      x_axis_scale: time
      series_colors:
        ventas.ingresos: '#5B5FEF'
        ventas.utilidad: '#087F8C'
      stacking: ''
      show_value_labels: false
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_x_axis_ticks: true
      show_y_axis_ticks: true
      font_size: 12px
      advanced_vis_config: |-
        {"chart":{"backgroundColor":"#FFFFFF","style":{"fontFamily":"Arial, sans-serif"}},"legend":{"itemStyle":{"color":"#334155","fontSize":"12px","fontWeight":"normal"},"itemHoverStyle":{"color":"#172B4D"},"symbolRadius":4},"xAxis":{"lineColor":"#D9E1EC","tickColor":"#D9E1EC","labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"yAxis":{"gridLineColor":"#E8EDF4","gridLineWidth":1,"labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"tooltip":{"backgroundColor":"#172B4D","borderColor":"#172B4D","borderRadius":8,"shadow":false,"style":{"color":"#FFFFFF","fontSize":"12px"}},"plotOptions":{"series":{"animation":false,"lineWidth":2.5,"marker":{"enabled":false}}}}
      series_labels:
        ventas.ingresos: Venta neta
        ventas.utilidad: Utilidad bruta
    - name: areas_categoria
      title: Evolución por categoría · MXN
      type: looker_area
      model: retail
      explore: ventas
      fields:
        - ventas.fecha_dinamica
        - productos.categoria
        - ventas.ingresos
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
        Granularidad: ventas.granularidad
      row: 15
      col: 0
      width: 14
      height: 8
      limit: 5000
      sorts:
        - ventas.fecha_dinamica
        - productos.categoria
      pivots:
        - productos.categoria
      colors: *id001
      show_view_names: false
      show_x_axis_label: false
      show_y_axis_labels: false
      legend_position: left
      hide_legend: false
      show_null_points: false
      discontinuous_nulls: false
      point_style: none
      interpolation: linear
      x_axis_scale: time
      stacking: normal
      series_colors:
        Deportes: '#4A78A8'
        Hogar: '#087F8C'
        Papelería: '#B87928'
        Tecnología: '#5B5FEF'
      show_value_labels: false
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_x_axis_ticks: true
      show_y_axis_ticks: true
      font_size: 12px
      advanced_vis_config: |-
        {"chart":{"backgroundColor":"#FFFFFF","style":{"fontFamily":"Arial, sans-serif"}},"legend":{"itemStyle":{"color":"#334155","fontSize":"12px","fontWeight":"normal"},"itemHoverStyle":{"color":"#172B4D"},"symbolRadius":4},"xAxis":{"lineColor":"#D9E1EC","tickColor":"#D9E1EC","labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"yAxis":{"gridLineColor":"#E8EDF4","gridLineWidth":1,"labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"tooltip":{"backgroundColor":"#172B4D","borderColor":"#172B4D","borderRadius":8,"shadow":false,"style":{"color":"#FFFFFF","fontSize":"12px"}},"plotOptions":{"series":{"animation":false,"lineWidth":2.5,"marker":{"enabled":false}},"area":{"fillOpacity":0.62,"lineWidth":1.5}}}
    - name: participacion_tiempo
      title: Participación por canal
      type: looker_column
      model: retail
      explore: ventas
      fields:
        - ventas.fecha_dinamica
        - ventas.canal
        - ventas.ingresos
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
        Granularidad: ventas.granularidad
      row: 15
      col: 14
      width: 10
      height: 8
      limit: 5000
      sorts:
        - ventas.fecha_dinamica
        - ventas.canal
      pivots:
        - ventas.canal
      colors: *id001
      show_view_names: false
      show_x_axis_label: false
      show_y_axis_labels: false
      stacking: percent
      series_colors: &id002
        App: '#4A78A8'
        Tienda: '#5B5FEF'
        Web: '#087F8C'
      hide_legend: false
      show_value_labels: false
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_x_axis_ticks: true
      show_y_axis_ticks: true
      legend_position: left
      font_size: 12px
      advanced_vis_config: |-
        {"chart":{"backgroundColor":"#FFFFFF","style":{"fontFamily":"Arial, sans-serif"}},"legend":{"itemStyle":{"color":"#334155","fontSize":"12px","fontWeight":"normal"},"itemHoverStyle":{"color":"#172B4D"},"symbolRadius":4},"xAxis":{"lineColor":"#D9E1EC","tickColor":"#D9E1EC","labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"yAxis":{"gridLineColor":"#E8EDF4","gridLineWidth":1,"labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"tooltip":{"backgroundColor":"#172B4D","borderColor":"#172B4D","borderRadius":8,"shadow":false,"style":{"color":"#FFFFFF","fontSize":"12px"}},"plotOptions":{"series":{"animation":false,"borderWidth":0,"borderRadius":3}}}
      discontinuous_nulls: false
    - name: titulo_portafolio
      type: text
      body_text: |-
        <div style="padding:12px 18px;border-radius:16px;background-color:#0F141B;background-image:linear-gradient(135deg,#0B0E11 0%,#142135 60%,#0B0E11 100%);border:1px solid rgba(234,236,239,0.10);box-shadow:0 3px 10px rgba(23,43,77,0.10);">
          <h2 style="color:#EAECEF;font-family:Arial,sans-serif;font-weight:800;font-size:20px;line-height:24px;letter-spacing:0.2px;margin:0;">Portafolio y rentabilidad</h2>
          <div style="margin-top:8px;height:4px;width:64px;background-color:#8D91FF;border-radius:999px;"></div>
        </div>
      row: 23
      col: 0
      width: 24
      height: 2
    - name: barras_categoria_canal
      title: Venta neta por categoría y canal · MXN
      type: looker_bar
      model: retail
      explore: ventas
      fields:
        - productos.categoria
        - ventas.canal
        - ventas.ingresos
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 25
      col: 0
      width: 14
      height: 8
      limit: 100
      sorts:
        - productos.categoria
        - ventas.canal
      pivots:
        - ventas.canal
      colors: *id001
      show_view_names: false
      show_x_axis_label: false
      show_y_axis_labels: false
      stacking: ''
      series_colors: *id002
      hide_legend: false
      show_value_labels: false
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_x_axis_ticks: true
      show_y_axis_ticks: true
      legend_position: left
      font_size: 12px
      advanced_vis_config: |-
        {"chart":{"backgroundColor":"#FFFFFF","style":{"fontFamily":"Arial, sans-serif"}},"legend":{"itemStyle":{"color":"#334155","fontSize":"12px","fontWeight":"normal"},"itemHoverStyle":{"color":"#172B4D"},"symbolRadius":4},"xAxis":{"lineColor":"#D9E1EC","tickColor":"#D9E1EC","labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"yAxis":{"gridLineColor":"#E8EDF4","gridLineWidth":1,"labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"tooltip":{"backgroundColor":"#172B4D","borderColor":"#172B4D","borderRadius":8,"shadow":false,"style":{"color":"#FFFFFF","fontSize":"12px"}},"plotOptions":{"series":{"animation":false,"borderWidth":0,"borderRadius":3}}}
    - name: dona_canales
      title: Distribución de venta neta por canal
      type: looker_pie
      model: retail
      explore: ventas
      fields:
        - ventas.canal
        - ventas.ingresos
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 25
      col: 14
      width: 10
      height: 8
      limit: 10
      sorts:
        - ventas.canal
      inner_radius: 72
      label_type: labPer
      value_labels: legend
      colors:
        - '#4A78A8'
        - '#5B5FEF'
        - '#087F8C'
      series_colors: *id002
      show_view_names: false
    - name: matriz_margen
      title: Margen por sucursal y categoría
      type: looker_grid
      model: retail
      explore: ventas
      fields:
        - sucursales.sucursal
        - productos.categoria
        - ventas.margen_grafico
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 33
      col: 0
      width: 14
      height: 8
      limit: 100
      sorts:
        - sucursales.sucursal
        - productos.categoria
      pivots:
        - productos.categoria
      show_view_names: false
      show_row_numbers: false
      header_background_color: '#172B4D'
      header_font_color: '#FFFFFF'
      header_font_size: 12
      rows_font_size: 12
      enable_conditional_formatting: true
      conditional_formatting_include_nulls: false
      conditional_formatting_include_totals: false
      conditional_formatting:
        - type: less than
          value: 0.2
          background_color: '#F1F5F9'
          font_color: '#64748B'
          bold: true
          italic: false
          strikethrough: false
          fields:
            - ventas.margen_grafico
        - type: between
          value:
            - 0.2
            - 0.3
          background_color: '#DCE1FF'
          font_color: '#353B86'
          bold: true
          italic: false
          strikethrough: false
          fields:
            - ventas.margen_grafico
        - type: greater than
          value: 0.3
          background_color: '#5B5FEF'
          font_color: '#FFFFFF'
          bold: true
          italic: false
          strikethrough: false
          fields:
            - ventas.margen_grafico
      table_theme: white
      header_text_alignment: left
      size_to_fit: true
      truncate_text: true
      hide_totals: false
      series_labels:
        sucursales.sucursal: Sucursal
        ventas.margen_grafico: Margen
      series_text_format:
        ventas.margen_grafico:
          align: center
    - name: dispersion
      title: Precio y margen por producto
      type: looker_scatter
      model: retail
      explore: ventas
      fields:
        - productos.precio_lista
        - productos.producto
        - ventas.margen_grafico
        - ventas.ventas_completadas
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 33
      col: 14
      width: 10
      height: 8
      limit: 100
      sorts:
        - productos.precio_lista
      colors:
        - '#087F8C'
      show_view_names: false
      show_x_axis_label: true
      show_y_axis_labels: true
      hidden_fields:
        - productos.producto
      size_by_field: ventas.ventas_completadas
      plot_size_by_field: false
      x_axis_scale: linear
      point_style: circle
      stacking: ''
      show_value_labels: false
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_x_axis_ticks: true
      show_y_axis_ticks: true
      legend_position: left
      font_size: 12px
      advanced_vis_config: |-
        {"chart":{"backgroundColor":"#FFFFFF","style":{"fontFamily":"Arial, sans-serif"}},"legend":{"itemStyle":{"color":"#334155","fontSize":"12px","fontWeight":"normal"},"itemHoverStyle":{"color":"#172B4D"},"symbolRadius":4},"xAxis":{"lineColor":"#D9E1EC","tickColor":"#D9E1EC","labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"yAxis":{"gridLineColor":"#E8EDF4","gridLineWidth":1,"labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"tooltip":{"backgroundColor":"#172B4D","borderColor":"#172B4D","borderRadius":8,"shadow":false,"style":{"color":"#FFFFFF","fontSize":"12px"}},"plotOptions":{"series":{"animation":false},"scatter":{"marker":{"lineWidth":1,"lineColor":"#FFFFFF"}}}}
      series_colors:
        ventas.margen_grafico: '#087F8C'
      x_axis_label: Precio de lista · MXN
      y_axis_labels:
        - Margen bruto
    - name: cascada_utilidad_categoria
      title: Contribución a la utilidad por categoría · MXN
      type: looker_waterfall
      model: retail
      explore: ventas
      fields:
        - productos.categoria
        - ventas.utilidad
      sorts:
        - ventas.utilidad desc
      limit: 100
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      show_view_names: false
      show_value_labels: false
      up_color: '#087F8C'
      down_color: '#B84A62'
      total_color: '#5B5FEF'
      show_x_axis_label: false
      show_x_axis_ticks: true
      show_y_axis_labels: false
      show_y_axis_ticks: true
      y_axis_gridlines: true
      advanced_vis_config: |-
        {"chart":{"backgroundColor":"#FFFFFF","style":{"fontFamily":"Arial, sans-serif"}},"legend":{"itemStyle":{"color":"#334155","fontSize":"12px","fontWeight":"normal"},"itemHoverStyle":{"color":"#172B4D"},"symbolRadius":4,"enabled":false},"xAxis":{"lineColor":"#D9E1EC","tickColor":"#D9E1EC","labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"yAxis":{"gridLineColor":"#E8EDF4","gridLineWidth":1,"labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"tooltip":{"backgroundColor":"#172B4D","borderColor":"#172B4D","borderRadius":8,"shadow":false,"style":{"color":"#FFFFFF","fontSize":"12px"}},"plotOptions":{"series":{"animation":false},"waterfall":{"borderWidth":0,"lineColor":"#CBD5E1","lineWidth":1}}}
      row: 41
      col: 0
      width: 24
      height: 8
    - name: titulo_operacion
      type: text
      body_text: |-
        <div style="padding:12px 18px;border-radius:16px;background-color:#0F141B;background-image:linear-gradient(135deg,#0B0E11 0%,#142135 60%,#0B0E11 100%);border:1px solid rgba(234,236,239,0.10);box-shadow:0 3px 10px rgba(23,43,77,0.10);">
          <h2 style="color:#EAECEF;font-family:Arial,sans-serif;font-weight:800;font-size:20px;line-height:24px;letter-spacing:0.2px;margin:0;">Clientes y operaciones</h2>
          <div style="margin-top:8px;height:4px;width:64px;background-color:#8D91FF;border-radius:999px;"></div>
        </div>
      row: 49
      col: 0
      width: 24
      height: 2
    - name: clientes_compradores
      title: Clientes compradores
      type: single_value
      model: retail
      explore: ventas
      fields:
        - ventas.clientes_compradores_kpi
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 51
      col: 0
      width: 8
      height: 3
      limit: 500
      custom_color_enabled: true
      custom_color: '#172B4D'
      show_single_value_title: true
      show_comparison: false
      single_value_title: Clientes compradores
    - name: venta_promedio
      title: Importe por venta completada · MXN
      type: single_value
      model: retail
      explore: ventas
      fields:
        - ventas.venta_promedio_kpi
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 51
      col: 8
      width: 8
      height: 3
      limit: 500
      custom_color_enabled: true
      custom_color: '#172B4D'
      show_single_value_title: true
      show_comparison: false
      single_value_title: Importe por venta completada · MXN
    - name: tasa_devolucion
      title: Operaciones devueltas · %
      type: single_value
      model: retail
      explore: ventas
      fields:
        - ventas.tasa_devolucion_kpi
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 51
      col: 16
      width: 8
      height: 3
      limit: 500
      custom_color_enabled: true
      custom_color: '#B87928'
      show_single_value_title: true
      show_comparison: false
      single_value_title: Operaciones devueltas · %
    - name: histograma
      title: Distribución de ventas completadas por importe · MXN
      type: looker_column
      model: retail
      explore: ventas
      fields:
        - ventas.intervalo_importe
        - ventas.ventas_completadas
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
        Intervalo: ventas.ancho_intervalo
      row: 54
      col: 0
      width: 14
      height: 8
      limit: 1000
      sorts:
        - ventas.intervalo_importe
      colors:
        - '#5B5FEF'
      show_view_names: false
      show_x_axis_label: true
      show_y_axis_labels: false
      filters:
        ventas.estado: Completada
      x_axis_scale: ordinal
      hide_legend: true
      show_value_labels: false
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_x_axis_ticks: true
      show_y_axis_ticks: true
      legend_position: left
      font_size: 12px
      advanced_vis_config: |-
        {"chart":{"backgroundColor":"#FFFFFF","style":{"fontFamily":"Arial, sans-serif"}},"legend":{"itemStyle":{"color":"#334155","fontSize":"12px","fontWeight":"normal"},"itemHoverStyle":{"color":"#172B4D"},"symbolRadius":4},"xAxis":{"lineColor":"#D9E1EC","tickColor":"#D9E1EC","labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"yAxis":{"gridLineColor":"#E8EDF4","gridLineWidth":1,"labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"tooltip":{"backgroundColor":"#172B4D","borderColor":"#172B4D","borderRadius":8,"shadow":false,"style":{"color":"#FFFFFF","fontSize":"12px"}},"plotOptions":{"series":{"animation":false,"borderWidth":0,"borderRadius":3}}}
      series_colors:
        ventas.ventas_completadas: '#5B5FEF'
      x_axis_label: Importe inicial del intervalo · MXN
    - name: boxplot_importe_canal
      title: Importe de ventas completadas por canal · MXN
      type: looker_boxplot
      model: retail
      explore: ventas
      fields:
        - ventas.canal
        - ventas.importe_minimo_completado
        - ventas.importe_p25_completado
        - ventas.importe_mediano_completado
        - ventas.importe_p75_completado
        - ventas.importe_maximo_completado
      sorts:
        - ventas.canal
      limit: 100
      filters:
        ventas.estado: Completada
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      show_view_names: false
      show_x_axis_label: false
      show_x_axis_ticks: true
      x_axis_gridlines: false
      show_y_axis_labels: false
      show_y_axis_ticks: true
      y_axis_gridlines: true
      advanced_vis_config: |-
        {"chart":{"backgroundColor":"#FFFFFF","style":{"fontFamily":"Arial, sans-serif"}},"legend":{"itemStyle":{"color":"#334155","fontSize":"12px","fontWeight":"normal"},"itemHoverStyle":{"color":"#172B4D"},"symbolRadius":4,"enabled":false},"xAxis":{"lineColor":"#D9E1EC","tickColor":"#D9E1EC","labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"yAxis":{"gridLineColor":"#E8EDF4","gridLineWidth":1,"labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"tooltip":{"backgroundColor":"#172B4D","borderColor":"#172B4D","borderRadius":8,"shadow":false,"style":{"color":"#FFFFFF","fontSize":"12px"}},"plotOptions":{"series":{"animation":false},"boxplot":{"color":"#087F8C","fillColor":"#DFF1F2","lineWidth":1.5,"medianColor":"#172B4D","medianWidth":2,"stemColor":"#087F8C","stemWidth":1.5,"whiskerColor":"#087F8C","whiskerWidth":1.5}}}
      row: 54
      col: 14
      width: 10
      height: 8
    - name: tasas
      title: Devoluciones y cancelaciones por canal
      type: looker_bar
      model: retail
      explore: ventas
      fields:
        - ventas.canal
        - ventas.tasa_devolucion
        - ventas.tasa_cancelacion
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 62
      col: 0
      width: 24
      height: 8
      limit: 10
      sorts:
        - ventas.tasa_devolucion desc
      colors: *id001
      show_view_names: false
      show_x_axis_label: false
      show_y_axis_labels: false
      stacking: ''
      series_colors:
        ventas.tasa_devolucion: '#B87928'
        ventas.tasa_cancelacion: '#B84A62'
      show_value_labels: true
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_x_axis_ticks: true
      show_y_axis_ticks: true
      legend_position: left
      font_size: 12px
      advanced_vis_config: |-
        {"chart":{"backgroundColor":"#FFFFFF","style":{"fontFamily":"Arial, sans-serif"}},"legend":{"itemStyle":{"color":"#334155","fontSize":"12px","fontWeight":"normal"},"itemHoverStyle":{"color":"#172B4D"},"symbolRadius":4},"xAxis":{"lineColor":"#D9E1EC","tickColor":"#D9E1EC","labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"yAxis":{"gridLineColor":"#E8EDF4","gridLineWidth":1,"labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"tooltip":{"backgroundColor":"#172B4D","borderColor":"#172B4D","borderRadius":8,"shadow":false,"style":{"color":"#FFFFFF","fontSize":"12px"}},"plotOptions":{"series":{"animation":false,"borderWidth":0,"borderRadius":3}}}
      series_labels:
        ventas.tasa_devolucion: Devoluciones
        ventas.tasa_cancelacion: Cancelaciones
      label_value_format: 0.0%
    - name: titulo_comparativo
      type: text
      body_text: |-
        <div style="padding:12px 18px;border-radius:16px;background-color:#0F141B;background-image:linear-gradient(135deg,#0B0E11 0%,#142135 60%,#0B0E11 100%);border:1px solid rgba(234,236,239,0.10);box-shadow:0 3px 10px rgba(23,43,77,0.10);">
          <h2 style="color:#EAECEF;font-family:Arial,sans-serif;font-weight:800;font-size:20px;line-height:24px;letter-spacing:0.2px;margin:0;">Comparativo interanual</h2>
          <div style="margin-top:8px;height:4px;width:64px;background-color:#8D91FF;border-radius:999px;"></div>
        </div>
      row: 70
      col: 0
      width: 24
      height: 2
    - name: valor_actual
      title: Indicador · periodo actual · MXN
      type: single_value
      model: retail
      explore: ventas
      fields:
        - ventas.valor_actual_kpi
      listen:
        Periodo: ventas.periodo_comparacion
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
        Metrica: ventas.metrica
      row: 72
      col: 0
      width: 6
      height: 3
      limit: 500
      custom_color_enabled: true
      custom_color: '#5B5FEF'
      show_single_value_title: true
      show_comparison: false
      single_value_title: Indicador · periodo actual · MXN
    - name: valor_anterior
      title: Indicador · año anterior · MXN
      type: single_value
      model: retail
      explore: ventas
      fields:
        - ventas.valor_anterior_kpi
      listen:
        Periodo: ventas.periodo_comparacion
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
        Metrica: ventas.metrica
      row: 72
      col: 6
      width: 6
      height: 3
      limit: 500
      custom_color_enabled: true
      custom_color: '#64748B'
      show_single_value_title: true
      show_comparison: false
      single_value_title: Indicador · año anterior · MXN
    - name: diferencia_interanual
      title: Cambio interanual · MXN
      type: single_value
      model: retail
      explore: ventas
      fields:
        - ventas.diferencia_interanual_kpi
      listen:
        Periodo: ventas.periodo_comparacion
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
        Metrica: ventas.metrica
      row: 72
      col: 12
      width: 6
      height: 3
      limit: 500
      custom_color_enabled: true
      custom_color: '#172B4D'
      show_single_value_title: true
      show_comparison: false
      single_value_title: Cambio interanual · MXN
    - name: variacion_interanual
      title: Variación interanual
      type: single_value
      model: retail
      explore: ventas
      fields:
        - ventas.variacion_interanual_kpi
      listen:
        Periodo: ventas.periodo_comparacion
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
        Metrica: ventas.metrica
      row: 72
      col: 18
      width: 6
      height: 3
      limit: 500
      custom_color_enabled: true
      custom_color: '#087F8C'
      show_single_value_title: true
      show_comparison: false
      single_value_title: Variación interanual
    - name: lineas_interanuales
      title: Evolución interanual · MXN
      type: looker_line
      model: retail
      explore: ventas
      fields:
        - ventas.fecha_comparable
        - ventas.valor_actual
        - ventas.valor_anterior
      listen:
        Periodo: ventas.periodo_comparacion
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
        Metrica: ventas.metrica
        Granularidad: ventas.granularidad
      row: 75
      col: 0
      width: 14
      height: 8
      limit: 5000
      sorts:
        - ventas.fecha_comparable
      colors: *id001
      show_view_names: false
      show_x_axis_label: false
      show_y_axis_labels: false
      legend_position: left
      hide_legend: false
      show_null_points: false
      discontinuous_nulls: true
      point_style: none
      interpolation: linear
      x_axis_scale: time
      filters:
        ventas.fecha_comparable: -NULL
      series_colors:
        ventas.valor_actual: '#5B5FEF'
        ventas.valor_anterior: '#8B9AAF'
      series_labels:
        ventas.valor_actual: Periodo actual
        ventas.valor_anterior: Año anterior
      stacking: ''
      show_value_labels: false
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_x_axis_ticks: true
      show_y_axis_ticks: true
      font_size: 12px
      advanced_vis_config: |-
        {"chart":{"backgroundColor":"#FFFFFF","style":{"fontFamily":"Arial, sans-serif"}},"legend":{"itemStyle":{"color":"#334155","fontSize":"12px","fontWeight":"normal"},"itemHoverStyle":{"color":"#172B4D"},"symbolRadius":4},"xAxis":{"lineColor":"#D9E1EC","tickColor":"#D9E1EC","labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"yAxis":{"gridLineColor":"#E8EDF4","gridLineWidth":1,"labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"tooltip":{"backgroundColor":"#172B4D","borderColor":"#172B4D","borderRadius":8,"shadow":false,"style":{"color":"#FFFFFF","fontSize":"12px"}},"plotOptions":{"series":{"animation":false,"lineWidth":2.5,"marker":{"enabled":false}}},"series":[{"name":"Periodo actual","lineWidth":3},{"name":"Año anterior","dashStyle":"ShortDash","lineWidth":2}]}
    - name: barras_diferencia
      title: Diferencia interanual por desglose · MXN
      type: looker_bar
      model: retail
      explore: ventas
      fields:
        - ventas.desglose_dinamico
        - ventas.diferencia_interanual
      listen:
        Periodo: ventas.periodo_comparacion
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
        Metrica: ventas.metrica
        Desglose: ventas.desglose
      row: 75
      col: 14
      width: 10
      height: 8
      limit: 100
      sorts:
        - ventas.diferencia_interanual desc
      colors:
        - '#5B5FEF'
      show_view_names: false
      show_x_axis_label: false
      show_y_axis_labels: false
      hide_legend: true
      series_colors:
        ventas.diferencia_interanual: '#5B5FEF'
      show_value_labels: false
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_x_axis_ticks: true
      show_y_axis_ticks: true
      legend_position: left
      font_size: 12px
      advanced_vis_config: |-
        {"chart":{"backgroundColor":"#FFFFFF","style":{"fontFamily":"Arial, sans-serif"}},"legend":{"itemStyle":{"color":"#334155","fontSize":"12px","fontWeight":"normal"},"itemHoverStyle":{"color":"#172B4D"},"symbolRadius":4},"xAxis":{"lineColor":"#D9E1EC","tickColor":"#D9E1EC","labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"yAxis":{"gridLineColor":"#E8EDF4","gridLineWidth":1,"labels":{"style":{"color":"#64748B","fontSize":"11px"}},"title":{"style":{"color":"#64748B","fontSize":"12px"}}},"tooltip":{"backgroundColor":"#172B4D","borderColor":"#172B4D","borderRadius":8,"shadow":false,"style":{"color":"#FFFFFF","fontSize":"12px"}},"plotOptions":{"series":{"animation":false,"borderWidth":0,"borderRadius":3}}}
    - name: titulo_detalle
      type: text
      body_text: |-
        <div style="padding:12px 18px;border-radius:16px;background-color:#0F141B;background-image:linear-gradient(135deg,#0B0E11 0%,#142135 60%,#0B0E11 100%);border:1px solid rgba(234,236,239,0.10);box-shadow:0 3px 10px rgba(23,43,77,0.10);">
          <h2 style="color:#EAECEF;font-family:Arial,sans-serif;font-weight:800;font-size:20px;line-height:24px;letter-spacing:0.2px;margin:0;">Detalle comercial</h2>
          <div style="margin-top:8px;height:4px;width:64px;background-color:#8D91FF;border-radius:999px;"></div>
        </div>
      row: 83
      col: 0
      width: 24
      height: 2
    - name: tabla_sucursales
      title: Desempeño por sucursal
      type: looker_grid
      model: retail
      explore: ventas
      fields:
        - sucursales.sucursal
        - ventas.ingresos
        - ventas.utilidad
        - ventas.margen
        - ventas.ventas_completadas
        - ventas.tasa_devolucion
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
      row: 85
      col: 0
      width: 13
      height: 8
      limit: 100
      sorts:
        - ventas.ingresos desc
      show_view_names: false
      show_row_numbers: false
      header_background_color: '#172B4D'
      header_font_color: '#FFFFFF'
      header_font_size: 12
      rows_font_size: 12
      table_theme: white
      header_text_alignment: left
      size_to_fit: true
      truncate_text: true
      hide_totals: false
      series_labels:
        sucursales.sucursal: Sucursal
        ventas.ingresos: Venta neta · MXN
        ventas.utilidad: Utilidad · MXN
        ventas.margen: Margen
        ventas.ventas_completadas: Ventas
        ventas.tasa_devolucion: Devolución
      series_text_format:
        ventas.ingresos:
          align: right
          fg_color: '#172B4D'
        ventas.utilidad:
          align: right
          fg_color: '#172B4D'
        ventas.margen:
          align: right
          fg_color: '#172B4D'
        ventas.ventas_completadas:
          align: right
          fg_color: '#172B4D'
        ventas.tasa_devolucion:
          align: right
          fg_color: '#172B4D'
        sucursales.sucursal:
          align: left
          bold: true
          fg_color: '#172B4D'
      series_value_format:
        ventas.ingresos:
          format_string: '#,##0'
        ventas.utilidad:
          format_string: '#,##0'
      series_column_widths:
        sucursales.sucursal: 145
    - name: tabla_productos
      title: Top 10 productos · indicador seleccionado
      type: looker_grid
      model: retail
      explore: ventas
      fields:
        - productos.producto_id
        - productos.producto
        - productos.categoria
        - ventas.metrica_dinamica
        - ventas.margen
      listen:
        Periodo: ventas.fecha_date
        Canal: ventas.canal
        Categoria: productos.categoria
        Producto: productos.producto
        Zona: sucursales.zona
        Sucursal: sucursales.sucursal
        Segmento: clientes.segmento
        Metrica: ventas.metrica
      row: 85
      col: 13
      width: 11
      height: 8
      limit: 10
      sorts:
        - ventas.metrica_dinamica desc
      show_view_names: false
      show_row_numbers: false
      header_background_color: '#172B4D'
      header_font_color: '#FFFFFF'
      header_font_size: 12
      rows_font_size: 12
      table_theme: white
      header_text_alignment: left
      size_to_fit: true
      truncate_text: true
      hide_totals: false
      series_labels:
        productos.producto_id: ID
        productos.producto: Producto
        productos.categoria: Categoría
        ventas.margen: Margen
      series_text_format:
        ventas.metrica_dinamica:
          align: right
          fg_color: '#172B4D'
        ventas.margen:
          align: right
          fg_color: '#172B4D'
        productos.producto_id:
          align: left
          bold: true
          fg_color: '#172B4D'
      series_value_format:
        ventas.metrica_dinamica:
          format_string: '#,##0'
      series_column_widths:
        productos.producto_id: 56
        productos.producto: 185
        productos.categoria: 100
  enable_viz_full_screen: true
