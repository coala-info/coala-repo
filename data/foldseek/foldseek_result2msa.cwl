cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - foldseek
  - result2msa
label: foldseek_result2msa
doc: 'Build multiple sequence alignments from a result database (one MSA per query).


  By Martin Steinegger (martin.steinegger@snu.ac.kr) & Milot Mirdita <milot@mirdita.de>
  & Clovis Galiez


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
  - id: result_db
    type: Directory
    doc: Result database
    inputBinding:
      position: 3
      valueFrom: $(self.path)/$(inputs.result_db_name)
  - id: result_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index,
      db.dbtype, db_h, db_ss, db_ca
  - id: output_msa_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 4
      valueFrom: out_db/$(self)
  - id: allow_deletion
    type:
      - 'null'
      - boolean
    doc: Allow deletions in a MSA
    inputBinding:
      position: 104
      prefix: --allow-deletion
  - id: comp_bias_corr
    type:
      - 'null'
      - int
    doc: Correct for locally biased amino acid composition (range 0-1)
    inputBinding:
      position: 104
      prefix: --comp-bias-corr
  - id: comp_bias_corr_scale
    type:
      - 'null'
      - float
    doc: Correct for locally biased amino acid composition (range 0-1)
    inputBinding:
      position: 104
      prefix: --comp-bias-corr-scale
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: cov
    type:
      - 'null'
      - float
    doc: Filter output MSAs using min. fraction of query residues covered by matched
      sequences [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --cov
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    inputBinding:
      position: 104
      prefix: --db-load-mode
  - id: diff
    type:
      - 'null'
      - int
    doc: Filter MSAs by selecting most diverse set of sequences, keeping at least
      this many seqs in each MSA block of length 50
    inputBinding:
      position: 104
      prefix: --diff
  - id: filter_min_enable
    type:
      - 'null'
      - int
    doc: Only filter MSAs with more than N sequences, 0 always filters
    inputBinding:
      position: 104
      prefix: --filter-min-enable
  - id: filter_msa
    type:
      - 'null'
      - int
    doc: 'Filter msa: 0: do not filter, 1: filter'
    inputBinding:
      position: 104
      prefix: --filter-msa
  - id: gap_extend
    type:
      - 'null'
      - string
    doc: Gap extension cost
    inputBinding:
      position: 104
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - string
    doc: Gap open cost
    inputBinding:
      position: 104
      prefix: --gap-open
  - id: max_seq_id
    type:
      - 'null'
      - float
    doc: Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --max-seq-id
  - id: msa_format_mode
    type:
      - 'null'
      - int
    doc: 'Format MSA as: 0: binary cA3M DB 1: binary ca3m w. consensus DB 2: aligned
      FASTA DB 3: aligned FASTA w. header summary 4: STOCKHOLM flat file 5: A3M format
      6: A3M format w. alignment info'
    inputBinding:
      position: 104
      prefix: --msa-format-mode
  - id: qid
    type:
      - 'null'
      - string
    doc: 'Reduce diversity of output MSAs using min.seq. identity with query sequences
      [0.0,1.0] Alternatively, can be a list of multiple thresholds: E.g.: 0.15,0.30,0.50
      to defines filter buckets of ]0.15-0.30] and ]0.30-0.50]'
    inputBinding:
      position: 104
      prefix: --qid
  - id: qsc
    type:
      - 'null'
      - float
    doc: Reduce diversity of output MSAs using min. score per aligned residue with
      query sequences [-50.0,100.0]
    inputBinding:
      position: 104
      prefix: --qsc
  - id: skip_query
    type:
      - 'null'
      - boolean
    doc: Skip the query sequence
    inputBinding:
      position: 104
      prefix: --skip-query
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: summary_prefix
    type:
      - 'null'
      - string
    doc: Set the cluster summary prefix
    inputBinding:
      position: 104
      prefix: --summary-prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_msa_db
    type: Directory
    doc: Directory holding the MSA database
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
