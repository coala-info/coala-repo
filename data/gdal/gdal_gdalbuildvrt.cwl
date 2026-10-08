cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdalbuildvrt
label: gdal_gdalbuildvrt
doc: "Builds a VRT (virtual raster) from a list of datasets.\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs:
  - id: output_vrt_name
    type: string
    doc: "Name of the output VRT file."
    inputBinding:
      position: 1
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input GDAL datasets (tiles of a mosaic, or bands with -separate)."
    inputBinding:
      position: 2
  - id: tile_index_field
    type:
      - 'null'
      - string
    doc: "Use the specified value as the tile index field, instead of the default value 'location'."
    inputBinding:
      position: 102
      prefix: -tileindex
  - id: resolution
    type:
      - 'null'
      - string
    doc: "Control how the output resolution is computed: highest, lowest, average or user."
    inputBinding:
      position: 102
      prefix: -resolution
  - id: extent
    type:
      - 'null'
      - type: array
        items: float
    doc: "Set georeferenced extents of VRT file: xmin ymin xmax ymax."
    inputBinding:
      position: 102
      prefix: -te
  - id: tr
    type:
      - 'null'
      - type: array
        items: float
    doc: "Set target resolution: xres yres (implies -resolution user)."
    inputBinding:
      position: 102
      prefix: -tr
  - id: align_to_max_extent
    type:
      - 'null'
      - boolean
    doc: "Align the coordinates of the extent of the output file to the values of the -tr."
    inputBinding:
      position: 102
      prefix: -tap
  - id: separate_bands
    type:
      - 'null'
      - boolean
    doc: "Place each input file into a separate band."
    inputBinding:
      position: 102
      prefix: -separate
  - id: band
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: -b
    doc: "Select an input band to be processed. Repeat for several bands."
    inputBinding:
      position: 102
  - id: subdataset
    type:
      - 'null'
      - string
    doc: "Select a subdataset by its number."
    inputBinding:
      position: 102
      prefix: -sd
  - id: allow_projection_difference
    type:
      - 'null'
      - boolean
    doc: "Accept source files that do not have the same projection."
    inputBinding:
      position: 102
      prefix: -allow_projection_difference
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress progress monitor and other non-error output."
    inputBinding:
      position: 102
      prefix: -q
  - id: add_alpha
    type:
      - 'null'
      - boolean
    doc: "Add an alpha mask band to the VRT when the source raster have none."
    inputBinding:
      position: 102
      prefix: -addalpha
  - id: hide_nodata
    type:
      - 'null'
      - boolean
    doc: "Do not set the nodata value of VRT bands."
    inputBinding:
      position: 102
      prefix: -hidenodata
  - id: source_nodata
    type:
      - 'null'
      - string
    doc: "Set nodata values at the input band level, as one quoted string: \"value [value...]\"."
    inputBinding:
      position: 102
      prefix: -srcnodata
  - id: vrt_nodata
    type:
      - 'null'
      - string
    doc: "Set nodata values at the output band level, as one quoted string: \"value [value...]\"."
    inputBinding:
      position: 102
      prefix: -vrtnodata
  - id: srs
    type:
      - 'null'
      - string
    doc: "Override the projection for the output file."
    inputBinding:
      position: 102
      prefix: -a_srs
  - id: resampling_method
    type:
      - 'null'
      - string
    doc: "Resampling algorithm: nearest, bilinear, cubic, cubicspline, lanczos, average or mode."
    inputBinding:
      position: 102
      prefix: -r
  - id: open_options
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -oo
    doc: "Open option for the input datasets (NAME=VALUE). Repeat as needed."
    inputBinding:
      position: 102
  - id: input_file_list
    type:
      - 'null'
      - File
    doc: "Text file with the names of the input files, one per line."
    inputBinding:
      position: 102
      prefix: -input_file_list
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite the VRT if it already exists."
    inputBinding:
      position: 102
      prefix: -overwrite
outputs:
  - id: output_vrt
    type: File
    doc: "The output VRT file."
    outputBinding:
      glob: $(inputs.output_vrt_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
