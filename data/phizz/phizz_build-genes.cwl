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
    doc: Gene file (gzip-compressed table, for example genes_37.txt.gz)
    inputBinding:
      position: 1
  - id: db_name
    type: string
    doc: Database name
    default: genes.db
    inputBinding:
      position: 102
      prefix: --db_name
  - id: db_path
    type:
      - 'null'
      - string
    doc: Path to store the database
    inputBinding:
      position: 102
      prefix: --path
outputs:
  - id: gene_db
    type: File
    doc: The gene database
    outputBinding:
      glob: $(inputs.db_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phizz:0.2.3--py_0
