cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdalwarp
label: gdal_gdalwarp
doc: "Reprojects a raster dataset to match a given projection, resolution and extent.\n\
  \nTool homepage: https://github.com/OSGeo/gdal"
inputs:
  - id: source_files
    type:
      type: array
      items: File
    doc: Source file(s).
    inputBinding:
      position: 1
  - id: align_to_pixels
    type:
      - 'null'
      - boolean
    doc: Align the output pixels to the grid.
    inputBinding:
      position: 102
      prefix: -tap
  - id: copy_metadata_conflict_value
    type:
      - 'null'
      - string
    doc: Value to use for conflicting metadata.
    inputBinding:
      position: 102
      prefix: -cvmd
  - id: creation_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Creation options for the output format.
    inputBinding:
      position: 102
      prefix: -co
  - id: crop_to_cutline
    type:
      - 'null'
      - boolean
    doc: Crop the output to the cutline.
    inputBinding:
      position: 102
      prefix: -crop_to_cutline
  - id: cutline_blend
    type:
      - 'null'
      - float
    doc: Blend distance in pixels for the cutline.
    inputBinding:
      position: 102
      prefix: -cblend
  - id: cutline_datasource
    type:
      - 'null'
      - File
    doc: Cutline datasource.
    inputBinding:
      position: 102
      prefix: -cutline
  - id: cutline_layer
    type:
      - 'null'
      - string
    doc: Layer of the cutline datasource.
    inputBinding:
      position: 102
      prefix: -cl
  - id: cutline_sql
    type:
      - 'null'
      - string
    doc: SQL statement for the cutline datasource.
    inputBinding:
      position: 102
      prefix: -csql
  - id: cutline_where
    type:
      - 'null'
      - string
    doc: Where clause for the cutline datasource.
    inputBinding:
      position: 102
      prefix: -cwhere
  - id: destination_alpha
    type:
      - 'null'
      - boolean
    doc: Add an alpha band to the output.
    inputBinding:
      position: 102
      prefix: -dstalpha
  - id: destination_dataset_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Destination dataset options.
    inputBinding:
      position: 102
      prefix: -doo
  - id: destination_nodata
    type:
      - 'null'
      - type: array
        items: string
    doc: Set nodata value for destination dataset.
    inputBinding:
      position: 102
      prefix: -dstnodata
  - id: error_threshold
    type:
      - 'null'
      - float
    doc: Error threshold for GCP-based transformations.
    inputBinding:
      position: 102
      prefix: -et
  - id: extent
    type:
      - 'null'
      - string
    doc: Set the output file extent to be in the range xmin, ymin, xmax, ymax.
    inputBinding:
      position: 102
      prefix: -te
  - id: geoloc
    type:
      - 'null'
      - boolean
    doc: Use geolocated image transformation.
    inputBinding:
      position: 102
      prefix: --geoloc
  - id: multi
    type:
      - 'null'
      - boolean
    doc: Use multithreaded warping.
    inputBinding:
      position: 102
      prefix: -multi
  - id: no_metadata
    type:
      - 'null'
      - boolean
    doc: Do not copy metadata.
    inputBinding:
      position: 102
      prefix: -nomd
  - id: no_vshift_grid
    type:
      - 'null'
      - boolean
    doc: Do not use vertical shift grid.
    inputBinding:
      position: 102
      prefix: --novshiftgrid
  - id: order
    type:
      - 'null'
      - int
    doc: Order of the polynomial transformation (default is 3).
    inputBinding:
      position: 102
  - id: output_dataset_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Output dataset options.
    inputBinding:
      position: 102
      prefix: -oo
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format.
    inputBinding:
      position: 102
      prefix: -of
  - id: output_type
    type:
      - 'null'
      - string
    doc: Output data type.
    inputBinding:
      position: 102
      prefix: -ot
  - id: overview_level
    type:
      - 'null'
      - string
    doc: Set the overview level to build. AUTO, AUTO-n, or NONE.
    inputBinding:
      position: 102
      prefix: -ovr
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite the output file if it exists.
    inputBinding:
      position: 102
      prefix: -overwrite
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress messages.
    inputBinding:
      position: 102
      prefix: -q
  - id: refine_gcps_minimum
    type:
      - 'null'
      - int
    doc: Minimum number of GCPs for refining.
    inputBinding:
      position: 102
  - id: refine_gcps_tolerance
    type:
      - 'null'
      - float
    doc: Tolerance for refining GCPs.
    inputBinding:
      position: 102
      prefix: -refine_gcps
  - id: resampling_method
    type:
      - 'null'
      - string
    doc: Resampling method to use.
    default: near
    inputBinding:
      position: 102
      prefix: -r
  - id: resolution
    type:
      - 'null'
      - string
    doc: Set the output file resolution (xres, yres in the units of the 
      projection).
    inputBinding:
      position: 102
      prefix: -tr
  - id: rpc
    type:
      - 'null'
      - boolean
    doc: Use Rational Polynomial Coefficients (RPC) transformation.
    inputBinding:
      position: 102
      prefix: --rpc
  - id: set_color_interpretation
    type:
      - 'null'
      - boolean
    doc: Set color interpretation.
    inputBinding:
      position: 102
      prefix: -setci
  - id: size
    type:
      - 'null'
      - string
    doc: Set the output file size in pixels (width, height).
    inputBinding:
      position: 102
      prefix: -ts
  - id: source_nodata
    type:
      - 'null'
      - type: array
        items: string
    doc: Set nodata value for source dataset.
    inputBinding:
      position: 102
      prefix: -srcnodata
  - id: source_srs
    type:
      - 'null'
      - string
    doc: Source Spatial Reference System. If omitted, the SRS is guessed from 
      the source file.
    inputBinding:
      position: 102
      prefix: -s_srs
  - id: target_srs
    type:
      - 'null'
      - string
    doc: Target Spatial Reference System. If omitted, the SRS is guessed from 
      the source file.
    inputBinding:
      position: 102
      prefix: -t_srs
  - id: tps
    type:
      - 'null'
      - boolean
    doc: Use Thin Plate Spline transformation.
    inputBinding:
      position: 102
      prefix: --tps
  - id: transformer_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options to pass to the transformer used for reprojection.
    inputBinding:
      position: 102
      prefix: -to
  - id: warp_memory
    type:
      - 'null'
      - int
    doc: Memory to use for warping in MB.
    inputBinding:
      position: 102
      prefix: -wm
  - id: warp_options
    type:
      - 'null'
      - type: array
        items: string
    doc: User-defined options to pass to the warp operation.
    inputBinding:
      position: 102
      prefix: -wo
  - id: warp_type
    type:
      - 'null'
      - string
    doc: Warp data type.
    inputBinding:
      position: 102
      prefix: -wt
outputs:
  - id: destination_file
    type: File
    doc: Destination file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
