cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - combinepvalperset
label: mmseqs2_combinepvalperset
doc: 'For each set of sequences, compute the combined p-value.


  By Ruoshi Zhang, Clovis Norroy & Milot Mirdita <milot@mirdita.de>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: query_set_db
    type: Directory
    doc: Query set database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.query_set_db_name)
  - id: query_set_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: target_set_db
    type: Directory
    doc: Target set database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.target_set_db_name)
  - id: target_set_db_name
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
  - id: output_pval_db_name
    type: string
    doc: Name (prefix) of the output p-value database, written inside the output directory
    inputBinding:
      position: 4
      valueFrom: out_db/$(self)
  - id: alpha
    type:
      - 'null'
      - float
    doc: Set alpha for combining p-values during aggregation
    inputBinding:
      position: 104
      prefix: --alpha
  - id: aggregation_mode
    type:
      - 'null'
      - int
    doc: 'Combined P-values computed from 0: multi-hit, 1: minimum of all P-values, 2: product-of-P-values,
      3: truncated product'
    inputBinding:
      position: 104
      prefix: --aggregation-mode
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
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the new database files
    outputBinding:
      glob: out_db
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for f in out_db/*; do if [ -L "$f" ]; then t=`readlink -f "$f"`; rm "$f";
      cp "$t" "$f"; fi; done'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
  - class: ShellCommandRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
