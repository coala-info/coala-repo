cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gdi
  - load
  - mlst-sistr
label: genomics-data-index_gdi load mlst-sistr
doc: "Load MLST-sistr data into the Genomics Data Index.\n\nTool homepage: https://github.com/apetkau/genomics-data-index"
inputs:
  - id: mlst_file
    type:
      - 'null'
      - type: array
        items: File
    doc: MLST file(s) to load
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
stdout: genomics-data-index_gdi load mlst-sistr.out
