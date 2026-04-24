cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdalbuildvrt
label: gdal_gdalbuildvrt
doc: "Builds a virtual raster (VRT) from a list of input GDAL datasets.\n\nTool homepage:
  https://github.com/OSGeo/gdal"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more input GDAL datasets.
    inputBinding:
      position: 1
  - id: add_alpha
    type:
      - 'null'
      - boolean
    doc: Add an alpha band to the VRT if it does not exist in the input 
      datasets.
    inputBinding:
      position: 102
      prefix: -addalpha
  - id: align_to_max_extent
    type:
      - 'null'
      - boolean
    doc: Align the output pixels to the maximum extent of the input files.
    inputBinding:
      position: 102
      prefix: -tap
  - id: allow_projection_difference
    type:
      - 'null'
      - boolean
    doc: Allow datasets with different projections to be added to the VRT.
    inputBinding:
      position: 102
      prefix: -allow_projection_difference
  - id: band
    type:
      - 'null'
      - type: array
        items: int
    doc: Selects a band to add into the VRT. Multiple bands can be listed. By 
      default, all bands are queried.
    inputBinding:
      position: 102
      prefix: -b
  - id: extent
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the output file's extent to the specified xmin, ymin, xmax, ymax in
      the output file's coordinate system.
    inputBinding:
      position: 102
      prefix: -te
  - id: hide_nodata
    type:
      - 'null'
      - boolean
    doc: Hide nodata values in the VRT.
    inputBinding:
      position: 102
      prefix: -hidenodata
  - id: input_file_list
    type:
      - 'null'
      - File
    doc: Path to a text file containing a list of input GDAL datasets.
    inputBinding:
      position: 102
      prefix: -input_file_list
  - id: open_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Open option for input datasets.
    inputBinding:
      position: 102
      prefix: -oo
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite the output VRT file if it already exists.
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
  - id: resampling_method
    type:
      - 'null'
      - string
    doc: "Set the resampling method. Options: 'nearest', 'bilinear', 'cubic', 'cubicspline',
      'lanczos', 'average', 'mode'."
    inputBinding:
      position: 102
      prefix: -r
  - id: resolution
    type:
      - 'null'
      - string
    doc: Controls how the output resolution is computed when input files have 
      different resolutions. Options are 'highest', 'lowest', 'average', or 
      'user'.
    inputBinding:
      position: 102
      prefix: -resolution
  - id: resolution_x
    type:
      - 'null'
      - float
    doc: Set the output file's resolution (x and y) in the output file's 
      coordinate system.
    inputBinding:
      position: 102
      prefix: -tr
  - id: resolution_y
    type:
      - 'null'
      - float
    doc: Set the output file's resolution (x and y) in the output file's 
      coordinate system.
    inputBinding:
      position: 102
      prefix: -tr
  - id: separate_bands
    type:
      - 'null'
      - boolean
    doc: Each input file goes into a separate band in the VRT. Otherwise, the 
      files are considered as tiles of a larger mosaic.
    inputBinding:
      position: 102
      prefix: -separate
  - id: source_nodata
    type:
      - 'null'
      - string
    doc: Set the nodata value for the source datasets.
    inputBinding:
      position: 102
      prefix: -srcnodata
  - id: srs
    type:
      - 'null'
      - string
    doc: Assign a spatial reference system to the VRT.
    inputBinding:
      position: 102
      prefix: -a_srs
  - id: subdataset
    type:
      - 'null'
      - string
    doc: Select a single subdataset by its number to be added to the VRT.
    inputBinding:
      position: 102
      prefix: -sd
  - id: tile_index_field
    type:
      - 'null'
      - string
    doc: Use the specified field from the tile index as the tile index field 
      name. The default tile index field is 'location'.
    inputBinding:
      position: 102
      prefix: -tileindex
  - id: vrt_nodata
    type:
      - 'null'
      - string
    doc: Set the nodata value for the VRT.
    inputBinding:
      position: 102
      prefix: -vrtnodata
outputs:
  - id: output_vrt
    type: File
    doc: The output VRT file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
