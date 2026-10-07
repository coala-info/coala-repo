cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chado
  - export
  - fasta
label: chado-tools_export_fasta
doc: "export genome/protein sequences from the CHADO database to a FASTA file\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose mode"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: config
    type:
      - 'null'
      - File
    doc: "YAML file containing connection details"
    inputBinding:
      position: 101
      prefix: --config
  - id: use_password
    type:
      - 'null'
      - boolean
    doc: "connect with password (default: no password)"
    inputBinding:
      position: 101
      prefix: --use_password
  - id: dbname
    type: string
    doc: "name of the database"
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: "FASTA output file"
    inputBinding:
      position: 101
      prefix: --output_file
  - id: organism
    type: string
    doc: "abbreviation/short name of the organism"
    inputBinding:
      position: 101
      prefix: --abbreviation
  - id: sequence_type
    type: string
    doc: "type of the sequences to be exported (choices: contigs, genes, proteins)"
    inputBinding:
      position: 101
      prefix: --sequence_type
  - id: release
    type:
      - 'null'
      - string
    doc: "name of the FASTA release"
    inputBinding:
      position: 101
      prefix: --release
  - id: include_obsolete
    type:
      - 'null'
      - boolean
    doc: "export all features, including obsoletes"
    inputBinding:
      position: 101
      prefix: --include_obsolete
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
