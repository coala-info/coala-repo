cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdalwarp
label: gdal_gdalwarp
doc: "Image reprojection and warping utility.\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs:
  - id: source_files
    type:
      type: array
      items: File
    doc: "Source raster file(s)."
    inputBinding:
      position: 1
  - id: destination_name
    type: string
    doc: "Name of the output (destination) file."
    inputBinding:
      position: 999
  - id: source_srs
    type:
      - 'null'
      - string
    doc: "Set source spatial reference (any form accepted by SetFromUserInput)."
    inputBinding:
      position: 102
      prefix: -s_srs
  - id: target_srs
    type:
      - 'null'
      - string
    doc: "Set target spatial reference (any form accepted by SetFromUserInput)."
    inputBinding:
      position: 102
      prefix: -t_srs
  - id: transformer_options
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -to
    doc: "Set a transformer option, NAME=VALUE. Repeat as needed."
    inputBinding:
      position: 102
  - id: no_vshift_grid
    type:
      - 'null'
      - boolean
    doc: "Disable the use of vertical shift grids."
    inputBinding:
      position: 102
      prefix: -novshiftgrid
  - id: order
    type:
      - 'null'
      - int
    doc: "Order of polynomial used for warping (1 to 3). The default is to select a polynomial order based on the number of GCPs."
    inputBinding:
      position: 102
      prefix: -order
  - id: tps
    type:
      - 'null'
      - boolean
    doc: "Force use of thin plate spline transformer based on available GCPs."
    inputBinding:
      position: 102
      prefix: -tps
  - id: rpc
    type:
      - 'null'
      - boolean
    doc: "Force the use of RPCs."
    inputBinding:
      position: 102
      prefix: -rpc
  - id: geoloc
    type:
      - 'null'
      - boolean
    doc: "Force use of Geolocation Arrays or RPC."
    inputBinding:
      position: 102
      prefix: -geoloc
  - id: error_threshold
    type:
      - 'null'
      - float
    doc: "Error threshold for transformation approximation (in pixel units; default 0.125)."
    inputBinding:
      position: 102
      prefix: -et
  - id: refine_gcps
    type:
      - 'null'
      - type: array
        items: float
    doc: "Refines the GCPs by automatically eliminating outliers: tolerance [minimum_gcps]."
    inputBinding:
      position: 102
      prefix: -refine_gcps
  - id: extent
    type:
      - 'null'
      - type: array
        items: float
    doc: "Set georeferenced extents of output file to be created: xmin ymin xmax ymax."
    inputBinding:
      position: 102
      prefix: -te
  - id: resolution
    type:
      - 'null'
      - type: array
        items: float
    doc: "Set output file resolution (in target georeferenced units): xres yres."
    inputBinding:
      position: 102
      prefix: -tr
  - id: align_to_pixels
    type:
      - 'null'
      - boolean
    doc: "Align the coordinates of the extent of the output file to the values of the -tr, such that the aligned extent includes the minimum extent."
    inputBinding:
      position: 102
      prefix: -tap
  - id: size
    type:
      - 'null'
      - type: array
        items: int
    doc: "Set output file size in pixels and lines: width height."
    inputBinding:
      position: 102
      prefix: -ts
  - id: overview_level
    type:
      - 'null'
      - string
    doc: "Specify which overview level of source files must be used: level, AUTO, AUTO-n or NONE."
    inputBinding:
      position: 102
      prefix: -ovr
  - id: warp_options
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -wo
    doc: "Set a warp option, NAME=VALUE. Repeat as needed."
    inputBinding:
      position: 102
  - id: output_type
    type:
      - 'null'
      - string
    doc: "Force the output image bands to have a specific data type (Byte, Int16, ...)."
    inputBinding:
      position: 102
      prefix: -ot
  - id: warp_type
    type:
      - 'null'
      - string
    doc: "Working pixel data type during warping (Byte, Int16, ...)."
    inputBinding:
      position: 102
      prefix: -wt
  - id: source_nodata
    type:
      - 'null'
      - string
    doc: "Set nodata masking values for input bands, as one quoted string: \"value [value...]\"."
    inputBinding:
      position: 102
      prefix: -srcnodata
  - id: destination_nodata
    type:
      - 'null'
      - string
    doc: "Set nodata values for output bands, as one quoted string: \"value [value...]\"."
    inputBinding:
      position: 102
      prefix: -dstnodata
  - id: destination_alpha
    type:
      - 'null'
      - boolean
    doc: "Create an output alpha band to identify nodata (unset/transparent) pixels."
    inputBinding:
      position: 102
      prefix: -dstalpha
  - id: resampling_method
    type:
      - 'null'
      - string
    doc: "Resampling method: near, bilinear, cubic, cubicspline, lanczos, average, mode, max, min, med, Q1 or Q3."
    inputBinding:
      position: 102
      prefix: -r
  - id: warp_memory
    type:
      - 'null'
      - int
    doc: "Set the amount of memory (in megabytes) that the warp API is allowed to use for caching."
    inputBinding:
      position: 102
      prefix: -wm
  - id: multi
    type:
      - 'null'
      - boolean
    doc: "Use multithreaded warping implementation."
    inputBinding:
      position: 102
      prefix: -multi
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress progress monitor and other non-error output."
    inputBinding:
      position: 102
      prefix: -q
  - id: cutline_datasource
    type:
      - 'null'
      - File
    doc: "Enable use of a blend cutline from the name OGR support datasource."
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
      position: 102
      prefix: -cutline
  - id: cutline_layer
    type:
      - 'null'
      - string
    doc: "Select the named layer from the cutline datasource."
    inputBinding:
      position: 102
      prefix: -cl
  - id: cutline_where
    type:
      - 'null'
      - string
    doc: "Restrict desired cutline features based on attribute query."
    inputBinding:
      position: 102
      prefix: -cwhere
  - id: cutline_sql
    type:
      - 'null'
      - string
    doc: "Select cutline features using an SQL query instead of from a layer with -cl."
    inputBinding:
      position: 102
      prefix: -csql
  - id: cutline_blend
    type:
      - 'null'
      - float
    doc: "Set a blend distance to use to blend over cutlines (in pixels)."
    inputBinding:
      position: 102
      prefix: -cblend
  - id: crop_to_cutline
    type:
      - 'null'
      - boolean
    doc: "Crop the extent of the target dataset to the extent of the cutline."
    inputBinding:
      position: 102
      prefix: -crop_to_cutline
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Select the output format (GDAL driver short name)."
    inputBinding:
      position: 102
      prefix: -of
  - id: creation_options
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -co
    doc: "Creation option for the output format (NAME=VALUE). Repeat as needed."
    inputBinding:
      position: 102
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite the target dataset if it already exists."
    inputBinding:
      position: 102
      prefix: -overwrite
  - id: no_metadata
    type:
      - 'null'
      - boolean
    doc: "Do not copy metadata."
    inputBinding:
      position: 102
      prefix: -nomd
  - id: copy_metadata_conflict_value
    type:
      - 'null'
      - string
    doc: "Metadata conflict value (-cvmd)."
    inputBinding:
      position: 102
      prefix: -cvmd
  - id: set_color_interpretation
    type:
      - 'null'
      - boolean
    doc: "Set the color interpretation of the bands of the target dataset from the source dataset."
    inputBinding:
      position: 102
      prefix: -setci
  - id: open_options
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -oo
    doc: "Open option for the source datasets (NAME=VALUE). Repeat as needed."
    inputBinding:
      position: 102
  - id: destination_dataset_options
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -doo
    doc: "Open option for the output dataset when it exists (NAME=VALUE). Repeat as needed."
    inputBinding:
      position: 102
outputs:
  - id: destination_file
    type:
      - 'null'
      - File
    doc: "The warped output file."
    outputBinding:
      glob: $(inputs.destination_name)
  - id: aux_xml
    type:
      - 'null'
      - File
    doc: "Auxiliary file, when written."
    outputBinding:
      glob: $(inputs.destination_name).aux.xml
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
