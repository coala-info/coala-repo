cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phizz
  - build-genes
label: phizz_build-genes
doc: "Create a gene database.\n\nTool homepage: https://github.com/moonso/phizz"
inputs:
  - id: gene_file
    type: File
    doc: Gene file
    inputBinding:
      position: 1
  - id: db_name
    type:
      - 'null'
      - string
    doc: Database name
    inputBinding:
      position: 102
  - id: path
    type:
      - 'null'
      - string
    doc: Path to store the database
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phizz:0.2.3--py_0
stdout: phizz_build-genes.out
