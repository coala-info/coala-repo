cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdalinfo
label: gdal_gdalinfo
doc: "Prints information about a GDAL dataset.\n\nTool homepage: https://github.com/OSGeo/gdal"
inputs:
  - id: datasetname
    type: string
    doc: The GDAL dataset name
    inputBinding:
      position: 1
  - id: checksum
    type:
      - 'null'
      - boolean
    doc: Report checksum of the file
    inputBinding:
      position: 102
      prefix: --checksum
  - id: compute_histogram
    type:
      - 'null'
      - boolean
    doc: Compute and display histogram for each band
    inputBinding:
      position: 102
      prefix: --hist
  - id: compute_stats
    type:
      - 'null'
      - boolean
    doc: Compute and display statistics for each band
    inputBinding:
      position: 102
      prefix: --stats
  - id: json
    type:
      - 'null'
      - boolean
    doc: Output in JSON format
    inputBinding:
      position: 102
      prefix: --json
  - id: list_mdd
    type:
      - 'null'
      - boolean
    doc: List all metadata domains
    inputBinding:
      position: 102
      prefix: --listmdd
  - id: mdd
    type:
      - 'null'
      - type: array
        items: string
    doc: Metadata domain to report. Can be specified multiple times or 'all'.
    inputBinding:
      position: 102
      prefix: --mdd
  - id: mm
    type:
      - 'null'
      - boolean
    doc: Report minimum/maximum pixel values
    inputBinding:
      position: 102
      prefix: --mm
  - id: no_ct
    type:
      - 'null'
      - boolean
    doc: Do not report Color Table
    inputBinding:
      position: 102
      prefix: --noct
  - id: no_fl
    type:
      - 'null'
      - boolean
    doc: Do not report File List
    inputBinding:
      position: 102
      prefix: --nofl
  - id: no_gcp
    type:
      - 'null'
      - boolean
    doc: Do not report Georeferencing Control Points
    inputBinding:
      position: 102
      prefix: --nogcp
  - id: no_md
    type:
      - 'null'
      - boolean
    doc: Do not report metadata
    inputBinding:
      position: 102
      prefix: --nomd
  - id: no_rat
    type:
      - 'null'
      - boolean
    doc: Do not report Raster Attribute Table
    inputBinding:
      position: 102
      prefix: --norat
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Format-specific dataset opening option. Can be specified multiple 
      times.
    inputBinding:
      position: 102
      prefix: --oo
  - id: proj4
    type:
      - 'null'
      - boolean
    doc: Report projection in Proj4 format
    inputBinding:
      position: 102
      prefix: --proj4
  - id: subdataset
    type:
      - 'null'
      - string
    doc: Select a subdataset to report on
    inputBinding:
      position: 102
      prefix: --sd
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdal:2.4.0
stdout: gdal_gdalinfo.out
