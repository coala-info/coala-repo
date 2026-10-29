cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - swapresults
label: mmseqs2_swapresults
doc: 'Transpose a prefilter or alignment database (swap query and target).


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
  - id: output_result_db_name
    type: string
    doc: Name (prefix) of the output result database, written inside the output directory
    inputBinding:
      position: 4
      valueFrom: out_db/$(self)
  - id: split_memory_limit
    type:
      - 'null'
      - string
    doc: Set max memory per split. E.g. 800B, 5K, 10M, 1G. Default (0) to all available system
      memory
    inputBinding:
      position: 104
      prefix: --split-memory-limit
  - id: e
    type:
      - 'null'
      - float
    doc: List matches below this E-value (range 0.0-inf)
    inputBinding:
      position: 104
      prefix: -e
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    inputBinding:
      position: 104
      prefix: --sub-mat
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
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    inputBinding:
      position: 104
      prefix: --db-load-mode
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
    doc: Directory holding the output database files
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
