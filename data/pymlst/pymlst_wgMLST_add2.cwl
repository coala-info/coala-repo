cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgMLST
  - add2
label: pymlst_wgMLST_add2
doc: "Adds a strain from FASTQS(.gz) reads to the wgMLST DATABASE.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database
    type: File
    doc: "Path to the wgMLST database (SQLite file); an updated copy is returned"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: fastqs
    type: File[]
    doc: "FASTQ files (optionally gzip-compressed); two files for paired reads"
    inputBinding:
      position: 2
  - id: strain
    type: ['null', string]
    doc: "Name of the strain (default:genome name)."
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
  - id: reads
    type: ['null', int]
    doc: "Minimum reads coverage to search a gene (default=10)."
    inputBinding:
      position: 10
      prefix: --reads
outputs:
  - id: updated_database
    type: File
    doc: "The wgMLST database with the strain added"
    outputBinding:
      glob: "$(inputs.database.basename)"
  - id: stdout
    type: stdout
    doc: "Standard output (result when no output file is given)"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_wgMLST_add2.out
