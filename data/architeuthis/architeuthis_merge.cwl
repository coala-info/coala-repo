cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - architeuthis
  - merge
label: architeuthis_merge
doc: "Merge results using architeuthis\n\nTool homepage: https://github.com/cdiener/architeuthis"
inputs:
  - id: db
    type:
      - 'null'
      - Directory
    doc: path to the Kraken database [optional]
    inputBinding:
      position: 101
      prefix: --db
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: The output filename.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
