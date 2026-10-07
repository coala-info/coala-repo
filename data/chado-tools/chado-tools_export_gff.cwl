cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chado
  - export
  - gff
label: chado-tools_export_gff
doc: "export genomic data from the CHADO database to a GFF3 file\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
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
    doc: "GFF output file"
    inputBinding:
      position: 101
      prefix: --output_file
  - id: organism
    type: string
    doc: "abbreviation/short name of the organism"
    inputBinding:
      position: 101
      prefix: --abbreviation
  - id: export_fasta
    type:
      - 'null'
      - boolean
    doc: "export FASTA sequences along with annotations"
    inputBinding:
      position: 101
      prefix: --export_fasta
  - id: fasta_file
    type:
      - 'null'
      - string
    doc: "FASTA output file with sequences (default: paste to end of GFF file)"
    inputBinding:
      position: 101
      prefix: --fasta_file
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
  - id: fasta_output
    type:
      - 'null'
      - File
    doc: FASTA file written with --export_fasta
    outputBinding:
      glob: $(inputs.fasta_file)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
