cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - foldseek
  - tmalign
label: foldseek_tmalign
doc: 'Compute TM-align alignments for the pairs of a prefilter result database.


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/steineggerlab/foldseek'
inputs:
  - id: query_db
    type: Directory
    doc: Query database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.query_db_name)
  - id: query_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index,
      db.dbtype, db_h, db_ss, db_ca
  - id: target_db
    type: Directory
    doc: Target database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.target_db_name)
  - id: target_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index,
      db.dbtype, db_h, db_ss, db_ca
  - id: prefilter_db
    type: Directory
    doc: Prefilter result database (candidate pairs)
    inputBinding:
      position: 3
      valueFrom: $(self.path)/$(inputs.prefilter_db_name)
  - id: prefilter_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index,
      db.dbtype, db_h, db_ss, db_ca
  - id: output_result_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 4
      valueFrom: out_db/$(self)
  - id: add_backtrace
    type:
      - 'null'
      - boolean
    doc: Add backtrace string (convert to alignments with mmseqs convertalis module)
    inputBinding:
      position: 104
      prefix: -a
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: '0: coverage of query and target 1: coverage of target 2: coverage of query
      3: target seq. length has to be at least x% of query length 4: query seq. length
      has to be at least x% of target length 5: short seq. needs to be at least x%
      of the other seq. length'
    inputBinding:
      position: 104
      prefix: --cov-mode
  - id: coverage
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see --cov-mode)
    inputBinding:
      position: 104
      prefix: -c
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    inputBinding:
      position: 104
      prefix: --db-load-mode
  - id: max_accept
    type:
      - 'null'
      - int
    doc: Maximum accepted alignments before alignment calculation for a query is stopped
    inputBinding:
      position: 104
      prefix: --max-accept
  - id: max_rejected
    type:
      - 'null'
      - int
    doc: Maximum rejected alignments before alignment calculation for a query is stopped
    inputBinding:
      position: 104
      prefix: --max-rejected
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 0.0-1.0)
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: tmalign_fast
    type:
      - 'null'
      - int
    doc: turn on fast search in TM-align
    inputBinding:
      position: 104
      prefix: --tmalign-fast
  - id: tmalign_hit_order
    type:
      - 'null'
      - int
    doc: 'order hits by 0: (qTM+tTM)/2, 1: qTM, 2: tTM, 3: min(qTM,tTM) 4: max(qTM,tTM)'
    inputBinding:
      position: 104
      prefix: --tmalign-hit-order
  - id: tmscore_threshold
    type:
      - 'null'
      - float
    doc: accept alignments with a tmsore > thr [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --tmscore-threshold
  - id: tmscore_threshold_mode
    type:
      - 'null'
      - int
    doc: '0: alignment, 1: query 2: target length'
    inputBinding:
      position: 104
      prefix: --tmscore-threshold-mode
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_result_db
    type: Directory
    doc: Directory holding the alignment result database
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
    dockerPull: quay.io/biocontainers/foldseek:10.941cd33--h5021889_1
