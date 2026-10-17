cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgMLST
  - add
label: pymlst_wgMLST_add
doc: "Adds a strain GENOME to the wgMLST DATABASE.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database
    type: File
    doc: "Path to the wgMLST database (SQLite file)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: genome
    type: File
    doc: "Genome assembly FASTA file"
    inputBinding:
      position: 2
  - id: strain
    type: ['null', string]
    doc: "Name of the strain (default: genome name)."
    inputBinding:
      position: 10
      prefix: --strain
  - id: identity
    type: ['null', float]
    doc: "Minimum identity to search gene (default=0.95)."
    inputBinding:
      position: 10
      prefix: --identity
  - id: coverage
    type: ['null', float]
    doc: "Minimum coverage to search gene (default=0.9)."
    inputBinding:
      position: 10
      prefix: --coverage
outputs:
  - id: updated_database
    type: File
    doc: "The wgMLST database with the strain added"
    outputBinding:
      glob: "$(inputs.database.basename)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_wgMLST_add.out
