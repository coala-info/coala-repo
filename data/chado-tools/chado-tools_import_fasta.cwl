cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chado
  - import
  - fasta
label: chado-tools_import_fasta
doc: "import sequences from a FASTA file into the CHADO database\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
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
  - id: input_file
    type: File
    doc: "FASTA input file"
    inputBinding:
      position: 101
      prefix: --input_file
  - id: organism
    type: string
    doc: "abbreviation/short name of the organism"
    inputBinding:
      position: 101
      prefix: --abbreviation
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: "type of the sequences (default: region) (choices: chromosome, supercontig, contig, region) [default: region]"
    inputBinding:
      position: 101
      prefix: --sequence_type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
stdout: chado-tools_import_fasta.out
