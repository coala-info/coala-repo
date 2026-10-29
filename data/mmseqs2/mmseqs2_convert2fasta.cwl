cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - convert2fasta
label: mmseqs2_convert2fasta
doc: 'Convert a sequence database to FASTA format.


  By Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: sequence_db
    type: Directory
    doc: Sequence database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.sequence_db_name)
  - id: sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: fasta_file
    type: string
    doc: Name of the output FASTA file
    inputBinding:
      position: 2
  - id: use_header_file
    type:
      - 'null'
      - int
    doc: use the sequence header DB instead of the body to map the entry keys (0 or 1)
    inputBinding:
      position: 104
      prefix: --use-header-file
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_fasta
    type: File
    doc: FASTA file
    outputBinding:
      glob: $(inputs.fasta_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
