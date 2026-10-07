cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chado
  - import
  - gff
label: chado-tools_import_gff
doc: "import genomic data from a GFF3 file into the CHADO database\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
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
    doc: "GFF3 input file"
    inputBinding:
      position: 101
      prefix: --input_file
  - id: organism
    type: string
    doc: "abbreviation/short name of the organism"
    inputBinding:
      position: 101
      prefix: --abbreviation
  - id: fasta
    type:
      - 'null'
      - File
    doc: "FASTA input file with sequences"
    inputBinding:
      position: 101
      prefix: --fasta
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: "type of the FASTA sequences, if present (default: region) (choices: chromosome, supercontig, contig, region) [default: region]"
    inputBinding:
      position: 101
      prefix: --sequence_type
  - id: fresh_load
    type:
      - 'null'
      - boolean
    doc: "load a genome from scratch (default: load an update to an existing genome)"
    inputBinding:
      position: 101
      prefix: --fresh_load
  - id: force
    type:
      - 'null'
      - boolean
    doc: "in case of a fresh load, purge all existing features of the organism"
    inputBinding:
      position: 101
      prefix: --force
  - id: full_genome
    type:
      - 'null'
      - boolean
    doc: "in case of an update, mark features not present in the input file as obsolete"
    inputBinding:
      position: 101
      prefix: --full_genome
  - id: full_attributes
    type:
      - 'null'
      - boolean
    doc: "in case of an update, delete feature attributes not present in the input file"
    inputBinding:
      position: 101
      prefix: --full_attributes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
stdout: chado-tools_import_gff.out
