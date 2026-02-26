cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogr2ogr
label: gdal_ogr2ogr
doc: "Convert data between vector formats\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs:
  - id: dst_datasource_name
    type: string
    doc: Destination data source name
    inputBinding:
      position: 1
  - id: src_datasource_name
    type: string
    doc: Source data source name
    inputBinding:
      position: 2
  - id: layers
    type:
      - 'null'
      - type: array
        items: string
    doc: Layers to convert
    inputBinding:
      position: 3
  - id: a_srs
    type:
      - 'null'
      - string
    doc: srs_def
    inputBinding:
      position: 104
      prefix: --a_srs
  - id: addfields
    type:
      - 'null'
      - boolean
    doc: add fields
    inputBinding:
      position: 104
      prefix: --addfields
  - id: append
    type:
      - 'null'
      - boolean
    doc: append
    inputBinding:
      position: 104
      prefix: --append
  - id: clipdst
    type:
      - 'null'
      - string
    doc: '[xmin ymin xmax ymax]|WKT|datasource'
    inputBinding:
      position: 104
      prefix: --clipdst
  - id: clipdstlayer
    type:
      - 'null'
      - string
    doc: layer
    inputBinding:
      position: 104
      prefix: --clipdstlayer
  - id: clipdstsql
    type:
      - 'null'
      - string
    doc: sql_statement
    inputBinding:
      position: 104
      prefix: --clipdstsql
  - id: clipdstwhere
    type:
      - 'null'
      - string
    doc: expression
    inputBinding:
      position: 104
      prefix: --clipdstwhere
  - id: clipsrc
    type:
      - 'null'
      - string
    doc: '[xmin ymin xmax ymax]|WKT|datasource|spat_extent'
    inputBinding:
      position: 104
      prefix: --clipsrc
  - id: clipsrclayer
    type:
      - 'null'
      - string
    doc: layer
    inputBinding:
      position: 104
      prefix: --clipsrclayer
  - id: clipsrcsql
    type:
      - 'null'
      - string
    doc: sql_statement
    inputBinding:
      position: 104
      prefix: --clipsrcsql
  - id: clipsrcwhere
    type:
      - 'null'
      - string
    doc: expression
    inputBinding:
      position: 104
      prefix: --clipsrcwhere
  - id: datelineoffset
    type:
      - 'null'
      - float
    doc: val
    inputBinding:
      position: 104
      prefix: --datelineoffset
  - id: dialect
    type:
      - 'null'
      - string
    doc: dialect
    inputBinding:
      position: 104
      prefix: --dialect
  - id: dim
    type:
      - 'null'
      - string
    doc: XY|XYZ|XYM|XYZM|layer_dim
    inputBinding:
      position: 104
      prefix: --dim
  - id: doo
    type:
      - 'null'
      - type: array
        items: string
    doc: NAME=VALUE
    inputBinding:
      position: 104
      prefix: --doo
  - id: ds_transaction
    type:
      - 'null'
      - boolean
    doc: Use data source transaction
    inputBinding:
      position: 104
      prefix: --ds_transaction
  - id: dsco
    type:
      - 'null'
      - type: array
        items: string
    doc: NAME=VALUE
    inputBinding:
      position: 104
      prefix: --dsco
  - id: explodecollections
    type:
      - 'null'
      - boolean
    doc: explode collections
    inputBinding:
      position: 104
      prefix: --explodecollections
  - id: fid
    type:
      - 'null'
      - string
    doc: FID
    inputBinding:
      position: 104
      prefix: --fid
  - id: fieldTypeToString
    type:
      - 'null'
      - string
    doc: All|(type1[,type2]*)
    inputBinding:
      position: 104
      prefix: --fieldTypeToString
  - id: fieldmap
    type:
      - 'null'
      - string
    doc: identity | index1[,index2]*
    inputBinding:
      position: 104
      prefix: --fieldmap
  - id: forceNullable
    type:
      - 'null'
      - boolean
    doc: force nullable
    inputBinding:
      position: 104
      prefix: --forceNullable
  - id: format
    type:
      - 'null'
      - string
    doc: format_name
    inputBinding:
      position: 104
      prefix: --f
  - id: gcp
    type:
      - 'null'
      - type: array
        items: string
    doc: ungeoref_x ungeoref_y georef_x georef_y [elevation]
    inputBinding:
      position: 104
      prefix: --gcp
  - id: geomfield
    type:
      - 'null'
      - string
    doc: field
    inputBinding:
      position: 104
      prefix: --geomfield
  - id: gt
    type:
      - 'null'
      - int
    doc: n
    inputBinding:
      position: 104
      prefix: --gt
  - id: lco
    type:
      - 'null'
      - type: array
        items: string
    doc: NAME=VALUE
    inputBinding:
      position: 104
      prefix: --lco
  - id: limit
    type:
      - 'null'
      - int
    doc: nb_features
    inputBinding:
      position: 104
      prefix: --limit
  - id: mapFieldType
    type:
      - 'null'
      - string
    doc: srctype|All=dsttype[,srctype2=dsttype2]*
    inputBinding:
      position: 104
      prefix: --mapFieldType
  - id: maxsubfields
    type:
      - 'null'
      - int
    doc: val
    inputBinding:
      position: 104
      prefix: --maxsubfields
  - id: mo
    type:
      - 'null'
      - type: array
        items: string
    doc: '"META-TAG=VALUE"'
    inputBinding:
      position: 104
      prefix: --mo
  - id: nln
    type:
      - 'null'
      - string
    doc: name
    inputBinding:
      position: 104
      prefix: --nln
  - id: nlt
    type:
      - 'null'
      - string
    doc: type|PROMOTE_TO_MULTI|CONVERT_TO_LINEAR|CONVERT_TO_CURVE
    inputBinding:
      position: 104
      prefix: --nlt
  - id: noNativeData
    type:
      - 'null'
      - boolean
    doc: no native data
    inputBinding:
      position: 104
      prefix: --noNativeData
  - id: nomd
    type:
      - 'null'
      - boolean
    doc: no metadata
    inputBinding:
      position: 104
      prefix: --nomd
  - id: oo
    type:
      - 'null'
      - type: array
        items: string
    doc: NAME=VALUE
    inputBinding:
      position: 104
      prefix: --oo
  - id: order
    type:
      - 'null'
      - int
    doc: n
    inputBinding:
      position: 104
      prefix: --order
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwrite
    inputBinding:
      position: 104
      prefix: --overwrite
  - id: preserve_fid
    type:
      - 'null'
      - boolean
    doc: preserve fid
    inputBinding:
      position: 104
      prefix: --preserve_fid
  - id: progress
    type:
      - 'null'
      - boolean
    doc: progress
    inputBinding:
      position: 104
      prefix: --progress
  - id: relaxedFieldNameMatch
    type:
      - 'null'
      - boolean
    doc: relaxed field name match
    inputBinding:
      position: 104
      prefix: --relaxedFieldNameMatch
  - id: s_srs
    type:
      - 'null'
      - string
    doc: srs_def
    inputBinding:
      position: 104
      prefix: --s_srs
  - id: segmentize
    type:
      - 'null'
      - float
    doc: max_dist
    inputBinding:
      position: 104
      prefix: --segmentize
  - id: select_fields
    type:
      - 'null'
      - string
    doc: field_list
    inputBinding:
      position: 104
      prefix: --select
  - id: simplify
    type:
      - 'null'
      - float
    doc: tolerance
    inputBinding:
      position: 104
      prefix: --simplify
  - id: skip_failures
    type:
      - 'null'
      - boolean
    doc: skip failures
    inputBinding:
      position: 104
      prefix: --skipfailures
  - id: spat
    type:
      - 'null'
      - string
    doc: xmin ymin xmax ymax
    inputBinding:
      position: 104
      prefix: --spat
  - id: spat_srs
    type:
      - 'null'
      - string
    doc: srs_def
    inputBinding:
      position: 104
      prefix: --spat_srs
  - id: splitlistfields
    type:
      - 'null'
      - boolean
    doc: split list fields
    inputBinding:
      position: 104
      prefix: --splitlistfields
  - id: sql
    type:
      - 'null'
      - string
    doc: sql statement|@filename
    inputBinding:
      position: 104
      prefix: --sql
  - id: t_srs
    type:
      - 'null'
      - string
    doc: srs_def
    inputBinding:
      position: 104
      prefix: --t_srs
  - id: tps
    type:
      - 'null'
      - boolean
    doc: Use TPS transformation
    inputBinding:
      position: 104
      prefix: --tps
  - id: unsetDefault
    type:
      - 'null'
      - boolean
    doc: unset default
    inputBinding:
      position: 104
      prefix: --unsetDefault
  - id: unsetFid
    type:
      - 'null'
      - boolean
    doc: unset FID
    inputBinding:
      position: 104
      prefix: --unsetFid
  - id: unsetFieldWidth
    type:
      - 'null'
      - boolean
    doc: unset field width
    inputBinding:
      position: 104
      prefix: --unsetFieldWidth
  - id: update
    type:
      - 'null'
      - boolean
    doc: update
    inputBinding:
      position: 104
      prefix: --update
  - id: where
    type:
      - 'null'
      - string
    doc: restricted_where|@filename
    inputBinding:
      position: 104
      prefix: --where
  - id: wrapdateline
    type:
      - 'null'
      - boolean
    doc: wrap dateline
    inputBinding:
      position: 104
      prefix: --wrapdateline
  - id: zfield
    type:
      - 'null'
      - string
    doc: field_name
    inputBinding:
      position: 104
      prefix: --zfield
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
stdout: gdal_ogr2ogr.out
