cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - result2flat
label: mmseqs2_result2flat
doc: 'Create a flat FASTA-like file from a result database, listing the target sequences found
  for each query.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: query_db
    type: Directory
    doc: Query database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.query_db_name)
  - id: query_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: target_db
    type: Directory
    doc: Target database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.target_db_name)
  - id: target_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: result_db
    type: Directory
    doc: Result database
    inputBinding:
      position: 3
      valueFrom: $(self.path)/$(inputs.result_db_name)
  - id: result_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: fasta_file
    type: string
    doc: Name of the output FASTA file
    inputBinding:
      position: 4
  - id: use_fasta_header
    type:
      - 'null'
      - int
    doc: Use the id parsed from the fasta header as the index key instead of using incrementing
      numeric identifiers (0 or 1)
    inputBinding:
      position: 104
      prefix: --use-fasta-header
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
    doc: Flat FASTA file
    outputBinding:
      glob: $(inputs.fasta_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
