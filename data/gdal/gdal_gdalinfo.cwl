cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdalinfo
label: gdal_gdalinfo
doc: "Lists information about a raster dataset.\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs:
  - id: datasetname
    type: File
    doc: "The GDAL dataset to report on."
    inputBinding:
      position: 1
  - id: json
    type:
      - 'null'
      - boolean
    doc: "Display the output in json format."
    inputBinding:
      position: 102
      prefix: -json
  - id: mm
    type:
      - 'null'
      - boolean
    doc: "Force computation of the actual min/max values for each band in the dataset."
    inputBinding:
      position: 102
      prefix: -mm
  - id: compute_stats
    type:
      - 'null'
      - boolean
    doc: "Read and display image statistics, computing them if not already present."
    inputBinding:
      position: 102
      prefix: -stats
  - id: compute_histogram
    type:
      - 'null'
      - boolean
    doc: "Report histogram information for all bands."
    inputBinding:
      position: 102
      prefix: -hist
  - id: no_gcp
    type:
      - 'null'
      - boolean
    doc: "Suppress ground control points list printing."
    inputBinding:
      position: 102
      prefix: -nogcp
  - id: no_md
    type:
      - 'null'
      - boolean
    doc: "Suppress metadata printing."
    inputBinding:
      position: 102
      prefix: -nomd
  - id: no_rat
    type:
      - 'null'
      - boolean
    doc: "Suppress printing of raster attribute table."
    inputBinding:
      position: 102
      prefix: -norat
  - id: no_ct
    type:
      - 'null'
      - boolean
    doc: "Suppress printing of color table."
    inputBinding:
      position: 102
      prefix: -noct
  - id: no_fl
    type:
      - 'null'
      - boolean
    doc: "Only display the first file of the file list."
    inputBinding:
      position: 102
      prefix: -nofl
  - id: checksum
    type:
      - 'null'
      - boolean
    doc: "Force computation of the checksum for each band in the dataset."
    inputBinding:
      position: 102
      prefix: -checksum
  - id: proj4
    type:
      - 'null'
      - boolean
    doc: "Report a PROJ.4 string corresponding to the file's coordinate system."
    inputBinding:
      position: 102
      prefix: -proj4
  - id: list_mdd
    type:
      - 'null'
      - boolean
    doc: "List all metadata domains available for the dataset."
    inputBinding:
      position: 102
      prefix: -listmdd
  - id: mdd
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -mdd
    doc: "Report metadata for the specified domain. 'all' reports all domains. Repeat for several domains."
    inputBinding:
      position: 102
  - id: subdataset
    type:
      - 'null'
      - string
    doc: "Use the subdataset of the specified index (starting at 1) instead of the base dataset."
    inputBinding:
      position: 102
      prefix: -sd
  - id: open_options
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -oo
    doc: "Dataset open option (format specific), NAME=VALUE. Repeat for several options."
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
stdout: gdal_gdalinfo.out
