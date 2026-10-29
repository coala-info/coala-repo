cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - rescorediagonal
label: mmseqs2_rescorediagonal
doc: 'Compute sequence identity for the diagonals found by a prefilter, giving an alignment
  database.


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
  - id: prefilter_db
    type: Directory
    doc: Prefilter result database
    inputBinding:
      position: 3
      valueFrom: $(self.path)/$(inputs.prefilter_db_name)
  - id: prefilter_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_result_db_name
    type: string
    doc: Name (prefix) of the output result database, written inside the output directory
    inputBinding:
      position: 4
      valueFrom: out_db/$(self)
  - id: add_self_matches
    type:
      - 'null'
      - int
    doc: Artificially add entries of queries with themselves (for clustering) (0 or 1)
    inputBinding:
      position: 104
      prefix: --add-self-matches
  - id: wrapped_scoring
    type:
      - 'null'
      - int
    doc: Double the (nucleotide) query sequence during the scoring process to allow wrapped
      diagonal scoring around end and start (0 or 1)
    inputBinding:
      position: 104
      prefix: --wrapped-scoring
  - id: e
    type:
      - 'null'
      - float
    doc: List matches below this E-value (range 0.0-inf)
    inputBinding:
      position: 104
      prefix: -e
  - id: c
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see --cov-mode)
    inputBinding:
      position: 104
      prefix: -c
  - id: a
    type:
      - 'null'
      - int
    doc: Add backtrace string (convert to alignments with mmseqs convertalis module) (0 or
      1)
    inputBinding:
      position: 104
      prefix: -a
  - id: cov_mode
    type:
      - 'null'
      - int
    doc: '0: coverage of query and target 1: coverage of target 2: coverage of query 3: target
      seq. length has to be at least x% of query length 4: query seq. length has to be at
      least x% of target length 5: short seq. needs to be at least x% of the other seq. length'
    inputBinding:
      position: 104
      prefix: --cov-mode
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 0.0-1.0)
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: min_aln_len
    type:
      - 'null'
      - int
    doc: Minimum alignment length (range 0-INT_MAX)
    inputBinding:
      position: 104
      prefix: --min-aln-len
  - id: seq_id_mode
    type:
      - 'null'
      - int
    doc: '0: alignment length 1: shorter, 2: longer sequence'
    inputBinding:
      position: 104
      prefix: --seq-id-mode
  - id: rescore_mode
    type:
      - 'null'
      - int
    doc: 'Rescore diagonals with: 0: Hamming distance 1: local alignment (score only) 2: local
      alignment 3: global alignment 4: longest alignment fulfilling window quality criterion'
    inputBinding:
      position: 104
      prefix: --rescore-mode
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    inputBinding:
      position: 104
      prefix: --db-load-mode
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
  - id: filter_hits
    type:
      - 'null'
      - int
    doc: Filter hits by seq.id. and coverage (0 or 1)
    inputBinding:
      position: 104
      prefix: --filter-hits
  - id: sort_results
    type:
      - 'null'
      - int
    doc: 'Sort results: 0: no sorting, 1: sort by E-value (Alignment) or seq.id. (Hamming)'
    inputBinding:
      position: 104
      prefix: --sort-results
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
