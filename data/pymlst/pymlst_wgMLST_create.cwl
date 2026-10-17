cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgMLST
  - create
label: pymlst_wgMLST_create
doc: "Creates a wgMLST DATABASE from a template COREGENE.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database_path
    type: string
    doc: "Name of the wgMLST database file to create"
    inputBinding:
      position: 1
  - id: coregene
    type: File
    doc: "Template core gene FASTA file"
    inputBinding:
      position: 2
  - id: force
    type: ['null', boolean]
    doc: "Overwrite already existing DATABASE"
    inputBinding:
      position: 10
      prefix: --force
  - id: concatenate
    type: ['null', boolean]
    doc: "Automatically concatenates GENES with duplicated sequences."
    inputBinding:
      position: 10
      prefix: --concatenate
  - id: remove
    type: ['null', boolean]
    doc: "Automatically removes GENES with duplicated sequences."
    inputBinding:
      position: 10
      prefix: --remove
  - id: species
    type: ['null', string]
    doc: "Name of the species"
    inputBinding:
      position: 10
      prefix: --species
  - id: version
    type: ['null', string]
    doc: "Version of the database"
    inputBinding:
      position: 10
      prefix: --version
outputs:
  - id: database
    type: File
    doc: "The created wgMLST database"
    outputBinding:
      glob: "$(inputs.database_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
