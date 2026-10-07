cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coreprofiler
  - db
  - makeblastdb
label: coreprofiler_db_makeblastdb
doc: "Run BLAST makeblasdtdb function.\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: scheme_path
    type: Directory
    doc: Path to directory containing allele files.
    inputBinding:
      position: 101
      prefix: --scheme_path
  - id: db_name
    type: string
    doc: BLAST db name.
    inputBinding:
      position: 101
      prefix: --db_name
  - id: db_path
    type: string
    doc: Path to write the database.
    inputBinding:
      position: 101
      prefix: --db_path
outputs:
  - id: database_dir
    type: Directory
    doc: Directory with the BLAST database.
    outputBinding:
      glob: $(inputs.db_path)
  - id: database
    type: File
    doc: Concatenated allele FASTA (<db_name>.fasta) with its BLAST index files; 
      give it to allele_calling --blast_db_path.
    outputBinding:
      glob: $(inputs.db_path)/$(inputs.db_name).fasta
    secondaryFiles:
      - .nhr
      - .nin
      - .nsq
      - pattern: .ndb
        required: false
      - pattern: .not
        required: false
      - pattern: .ntf
        required: false
      - pattern: .nto
        required: false
      - pattern: .njs
        required: false
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
