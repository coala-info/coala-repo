cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - claMLST
  - create
label: pymlst_claMLST_create
doc: "Creates a classical MLST DATABASE from a txt PROFILE and fasta ALLELES files.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: database_path
    type: string
    doc: "Name of the claMLST database (SQLite file) to create"
    inputBinding:
      position: 1
  - id: profile
    type: File
    doc: "Tab-delimited ST profile table (ST and one column per gene)"
    inputBinding:
      position: 2
  - id: alleles
    type: File[]
    doc: "FASTA files of the allele sequences, one per gene"
    inputBinding:
      position: 3
  - id: force
    type: ['null', boolean]
    doc: "Overwrites alrealdy existing DATABASE"
    inputBinding:
      position: 10
      prefix: --force
  - id: species
    type: ['null', string]
    doc: "Name of the species"
    inputBinding:
      position: 10
      prefix: --species
  - id: db_version
    type: ['null', string]
    doc: "Version of the database"
    inputBinding:
      position: 10
      prefix: --version
outputs:
  - id: database
    type: File
    doc: "The created claMLST database"
    outputBinding:
      glob: "$(inputs.database_path)"
  - id: stdout
    type: stdout
    doc: "Standard output (result when no output file is given)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_claMLST_create.out
