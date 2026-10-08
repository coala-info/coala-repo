cwlVersion: v1.2
class: CommandLineTool
baseCommand: ogr2ogr
label: gdal_ogr2ogr
doc: "Converts simple features data between file formats.\n\nTool homepage: https://github.com/OSGeo/gdal"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: dst_datasource_name
    type: string
    doc: "Output datasource name (file or directory to create or update)."
    inputBinding:
      position: 1
  - id: src_datasource_name
    type: File
    doc: "Input datasource (for a shapefile, the .shx, .dbf, .prj and .cpg files are staged beside it)."
    secondaryFiles:
      - pattern: ^.shx
        required: false
      - pattern: ^.dbf
        required: false
      - pattern: ^.prj
        required: false
      - pattern: ^.cpg
        required: false
    inputBinding:
      position: 2
  - id: layers
    type:
      - 'null'
      - type: array
        items: string
    doc: "Names of the layers to convert (all layers when not given)."
    inputBinding:
      position: 3
  - id: skip_failures
    type:
      - 'null'
      - boolean
    doc: "Continue after a failure, skipping the failed feature."
    inputBinding:
      position: 104
      prefix: -skipfailures
  - id: append
    type:
      - 'null'
      - boolean
    doc: "Append to existing layer instead of creating new."
    inputBinding:
      position: 104
      prefix: -append
  - id: update
    type:
      - 'null'
      - boolean
    doc: "Open existing output datasource in update mode rather than trying to create a new one."
    inputBinding:
      position: 104
      prefix: -update
  - id: select_fields
    type:
      - 'null'
      - string
    doc: "Comma-delimited list of fields from input layer to copy to the new layer."
    inputBinding:
      position: 104
      prefix: -select
  - id: where
    type:
      - 'null'
      - string
    doc: "Attribute query (like SQL WHERE) restricting the features copied."
    inputBinding:
      position: 104
      prefix: -where
  - id: progress
    type:
      - 'null'
      - boolean
    doc: "Display a progress meter using a GDAL progress function."
    inputBinding:
      position: 104
      prefix: -progress
  - id: sql
    type:
      - 'null'
      - string
    doc: "SQL statement to execute; the resulting table is written to the output."
    inputBinding:
      position: 104
      prefix: -sql
  - id: dialect
    type:
      - 'null'
      - string
    doc: "SQL dialect (OGRSQL, SQLITE, ...)."
    inputBinding:
      position: 104
      prefix: -dialect
  - id: preserve_fid
    type:
      - 'null'
      - boolean
    doc: "Use the FID of the source features instead of letting the output driver automatically assign a new one."
    inputBinding:
      position: 104
      prefix: -preserve_fid
  - id: fid
    type:
      - 'null'
      - string
    doc: "If provided, only the feature with this feature id will be reported."
    inputBinding:
      position: 104
      prefix: -fid
  - id: limit
    type:
      - 'null'
      - int
    doc: "Limit the number of features read per layer."
    inputBinding:
      position: 104
      prefix: -limit
  - id: spat
    type:
      - 'null'
      - type: array
        items: float
    doc: "Spatial query extents in the SRS of the layer: xmin ymin xmax ymax."
    inputBinding:
      position: 104
      prefix: -spat
  - id: spat_srs
    type:
      - 'null'
      - string
    doc: "Override spatial filter SRS."
    inputBinding:
      position: 104
      prefix: -spat_srs
  - id: geomfield
    type:
      - 'null'
      - string
    doc: "Name of the geometry field on which the spatial filter operates."
    inputBinding:
      position: 104
      prefix: -geomfield
  - id: a_srs
    type:
      - 'null'
      - string
    doc: "Assign an output SRS, but without reprojecting."
    inputBinding:
      position: 104
      prefix: -a_srs
  - id: t_srs
    type:
      - 'null'
      - string
    doc: "Reproject/transform to this SRS on output."
    inputBinding:
      position: 104
      prefix: -t_srs
  - id: s_srs
    type:
      - 'null'
      - string
    doc: "Override source SRS."
    inputBinding:
      position: 104
      prefix: -s_srs
  - id: format
    type:
      - 'null'
      - string
    doc: "Output file format name (GPKG, GeoJSON, ESRI Shapefile, CSV, KML, ...)."
    inputBinding:
      position: 104
      prefix: -f
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Delete the output layer and recreate it empty."
    inputBinding:
      position: 104
      prefix: -overwrite
  - id: dsco
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -dsco
    doc: "Dataset creation option (format specific), NAME=VALUE. Repeat as needed."
    inputBinding:
      position: 104
  - id: lco
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -lco
    doc: "Layer creation option (format specific), NAME=VALUE. Repeat as needed."
    inputBinding:
      position: 104
  - id: nln
    type:
      - 'null'
      - string
    doc: "Assign an alternate name to the new layer."
    inputBinding:
      position: 104
      prefix: -nln
  - id: nlt
    type:
      - 'null'
      - string
    doc: "Define the geometry type for the created layer (NONE, GEOMETRY, POINT, ..., PROMOTE_TO_MULTI, CONVERT_TO_LINEAR, CONVERT_TO_CURVE)."
    inputBinding:
      position: 104
      prefix: -nlt
  - id: dim
    type:
      - 'null'
      - string
    doc: "Force the coordinate dimension to XY, XYZ, XYM, XYZM or layer_dim."
    inputBinding:
      position: 104
      prefix: -dim
  - id: gt
    type:
      - 'null'
      - int
    doc: "Group n features per transaction (default 20000)."
    inputBinding:
      position: 104
      prefix: -gt
  - id: ds_transaction
    type:
      - 'null'
      - boolean
    doc: "Force the use of a dataset level transaction if available."
    inputBinding:
      position: 104
      prefix: -ds_transaction
  - id: oo
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -oo
    doc: "Input dataset open option (NAME=VALUE). Repeat as needed."
    inputBinding:
      position: 104
  - id: doo
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -doo
    doc: "Destination dataset open option (NAME=VALUE). Repeat as needed."
    inputBinding:
      position: 104
  - id: clipsrc
    type:
      - 'null'
      - type: array
        items: string
    doc: "Clip geometries to the specified bounding box (xmin ymin xmax ymax), a WKT geometry, a datasource, or spat_extent."
    inputBinding:
      position: 104
      prefix: -clipsrc
  - id: clipsrcsql
    type:
      - 'null'
      - string
    doc: "Select desired geometries using an SQL query for -clipsrc."
    inputBinding:
      position: 104
      prefix: -clipsrcsql
  - id: clipsrclayer
    type:
      - 'null'
      - string
    doc: "Select the named layer from the source clip datasource."
    inputBinding:
      position: 104
      prefix: -clipsrclayer
  - id: clipsrcwhere
    type:
      - 'null'
      - string
    doc: "Restrict desired geometries based on attribute query for -clipsrc."
    inputBinding:
      position: 104
      prefix: -clipsrcwhere
  - id: clipdst
    type:
      - 'null'
      - type: array
        items: string
    doc: "Clip geometries after reprojection to the specified bounding box (xmin ymin xmax ymax), a WKT geometry or a datasource."
    inputBinding:
      position: 104
      prefix: -clipdst
  - id: clipdstsql
    type:
      - 'null'
      - string
    doc: "Select desired geometries using an SQL query for -clipdst."
    inputBinding:
      position: 104
      prefix: -clipdstsql
  - id: clipdstlayer
    type:
      - 'null'
      - string
    doc: "Select the named layer from the destination clip datasource."
    inputBinding:
      position: 104
      prefix: -clipdstlayer
  - id: clipdstwhere
    type:
      - 'null'
      - string
    doc: "Restrict desired geometries based on attribute query for -clipdst."
    inputBinding:
      position: 104
      prefix: -clipdstwhere
  - id: wrapdateline
    type:
      - 'null'
      - boolean
    doc: "Split geometries crossing the dateline meridian."
    inputBinding:
      position: 104
      prefix: -wrapdateline
  - id: datelineoffset
    type:
      - 'null'
      - float
    doc: "Offset from dateline in degrees (default long. = +/- 10deg)."
    inputBinding:
      position: 104
      prefix: -datelineoffset
  - id: simplify
    type:
      - 'null'
      - float
    doc: "Distance tolerance for simplification."
    inputBinding:
      position: 104
      prefix: -simplify
  - id: segmentize
    type:
      - 'null'
      - float
    doc: "Maximum distance between 2 nodes; used to create intermediate points."
    inputBinding:
      position: 104
      prefix: -segmentize
  - id: addfields
    type:
      - 'null'
      - boolean
    doc: "Add new fields to an existing layer (use with -append)."
    inputBinding:
      position: 104
      prefix: -addfields
  - id: unsetFid
    type:
      - 'null'
      - boolean
    doc: "Can be specified to prevent the new layer from using the source FID column."
    inputBinding:
      position: 104
      prefix: -unsetFid
  - id: relaxedFieldNameMatch
    type:
      - 'null'
      - boolean
    doc: "Do a relaxed field name comparison when appending."
    inputBinding:
      position: 104
      prefix: -relaxedFieldNameMatch
  - id: forceNullable
    type:
      - 'null'
      - boolean
    doc: "Do not propagate not-nullable constraints to the new layer."
    inputBinding:
      position: 104
      prefix: -forceNullable
  - id: unsetDefault
    type:
      - 'null'
      - boolean
    doc: "Do not propagate default field values to the new layer."
    inputBinding:
      position: 104
      prefix: -unsetDefault
  - id: fieldTypeToString
    type:
      - 'null'
      - string
    doc: "Convert fields of the given types (All or a comma separated list) to string."
    inputBinding:
      position: 104
      prefix: -fieldTypeToString
  - id: unsetFieldWidth
    type:
      - 'null'
      - boolean
    doc: "Set field width and precision to 0."
    inputBinding:
      position: 104
      prefix: -unsetFieldWidth
  - id: mapFieldType
    type:
      - 'null'
      - string
    doc: "Convert field types (srctype|All=dsttype[,srctype2=dsttype2]*)."
    inputBinding:
      position: 104
      prefix: -mapFieldType
  - id: fieldmap
    type:
      - 'null'
      - string
    doc: "Specifies the list of field indexes to be copied from the source to the destination (identity or index1[,index2]*)."
    inputBinding:
      position: 104
      prefix: -fieldmap
  - id: splitlistfields
    type:
      - 'null'
      - boolean
    doc: "Split fields of type StringList, RealList or IntegerList into as many fields of type String, Real or Integer as necessary."
    inputBinding:
      position: 104
      prefix: -splitlistfields
  - id: maxsubfields
    type:
      - 'null'
      - int
    doc: "Maximum number of subfields created for each split list field."
    inputBinding:
      position: 104
      prefix: -maxsubfields
  - id: explodecollections
    type:
      - 'null'
      - boolean
    doc: "Produce one feature for each geometry in any kind of geometry collection in the source file."
    inputBinding:
      position: 104
      prefix: -explodecollections
  - id: zfield
    type:
      - 'null'
      - string
    doc: "Field name from which to take the Z coordinate."
    inputBinding:
      position: 104
      prefix: -zfield
  - id: gcp
    type:
      - 'null'
      - type: array
        items: float
    doc: "Add a ground control point: ungeoref_x ungeoref_y georef_x georef_y [elevation]."
    inputBinding:
      position: 104
      prefix: -gcp
  - id: order
    type:
      - 'null'
      - int
    doc: "Order of polynomial used for warping (1 to 3)."
    inputBinding:
      position: 104
      prefix: -order
  - id: tps
    type:
      - 'null'
      - boolean
    doc: "Force use of thin plate spline transformer based on available GCPs."
    inputBinding:
      position: 104
      prefix: -tps
  - id: nomd
    type:
      - 'null'
      - boolean
    doc: "Do not copy metadata."
    inputBinding:
      position: 104
      prefix: -nomd
  - id: mo
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -mo
    doc: "Passes a metadata key and value to set on the output dataset (META-TAG=VALUE). Repeat as needed."
    inputBinding:
      position: 104
  - id: noNativeData
    type:
      - 'null'
      - boolean
    doc: "Do not copy native data."
    inputBinding:
      position: 104
      prefix: -noNativeData
outputs:
  - id: output_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files of the output datasource (all files named like the output without its extension, e.g. .shp, .shx, .dbf, .prj)."
    outputBinding:
      glob: $(inputs.dst_datasource_name.replace(/\.[^.]*$/, ''))*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
