cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - tabix-index
label: fuc_tabix-index
doc: "Index a GFF/BED/SAM/VCF file with Tabix.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: file
    type: File
    doc: File to be indexed.
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force to overwrite the index file if it is present.
    inputBinding:
      position: 102
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_tabix-index.out
