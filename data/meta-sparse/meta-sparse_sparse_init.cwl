cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sparse
  - init
label: meta-sparse_sparse_init
doc: "Create an empty SPARSE database. Use sparse index to fill in references later.\n\nTool homepage: https://github.com/zheminzhou/SPARSE"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: dbname
    type: string
    doc: "Name for the new database to be generated"
    inputBinding:
      position: 1
      prefix: --dbname
outputs:
  - id: database
    type: Directory
    doc: "New empty SPARSE database folder"
    outputBinding:
      glob: $(inputs.dbname)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-sparse:0.1.12--py27h24bf2e0_0
