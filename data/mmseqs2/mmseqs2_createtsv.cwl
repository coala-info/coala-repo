cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - createtsv
label: mmseqs2_createtsv
doc: 'Convert a result database (for example a cluster database) into a tab-separated file.


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
    type:
      - 'null'
      - Directory
    doc: Target database; give it to get sequence names instead of numeric keys in the second
      column
    inputBinding:
      position: 2
      valueFrom: '$(self === null ? null : self.path + "/" + inputs.target_db_name)'
  - id: target_db_name
    type:
      - 'null'
      - string
    doc: Name (prefix) of the target database inside target_db
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
  - id: tsv_file
    type: string
    doc: Name of the output file
    inputBinding:
      position: 4
  - id: first_seq_as_repr
    type:
      - 'null'
      - int
    doc: Use the first sequence of the clustering result as representative sequence (0 or
      1)
    inputBinding:
      position: 104
      prefix: --first-seq-as-repr
  - id: target_column
    type:
      - 'null'
      - int
    doc: Select a target column (default 1), 0 if no target id exists
    inputBinding:
      position: 104
      prefix: --target-column
  - id: full_header
    type:
      - 'null'
      - int
    doc: Replace DB ID by its corresponding Full Header (0 or 1)
    inputBinding:
      position: 104
      prefix: --full-header
  - id: idx_seq_src
    type:
      - 'null'
      - int
    doc: '0: auto, 1: split/translated sequences, 2: input sequences'
    inputBinding:
      position: 104
      prefix: --idx-seq-src
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
  - id: db_output
    type:
      - 'null'
      - int
    doc: Return a result DB instead of a text file (0 or 1)
    inputBinding:
      position: 104
      prefix: --db-output
outputs:
  - id: output_tsv
    type: File
    doc: Tab-separated result file
    outputBinding:
      glob: $(inputs.tsv_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
