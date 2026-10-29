cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - expandaln
label: mmseqs2_expandaln
doc: 'Expand an alignment result with a second result (or cA3M) database and write a new alignment
  database.


  By Milot Mirdita <milot@mirdita.de>


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
    doc: Result database of query against target
    inputBinding:
      position: 3
      valueFrom: $(self.path)/$(inputs.result_db_name)
  - id: result_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: expansion_db
    type: Directory
    doc: Result or cA3M database that expands the target hits
    inputBinding:
      position: 4
      valueFrom: $(self.path)/$(inputs.expansion_db_name)
  - id: expansion_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_alignment_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 5
      valueFrom: out_db/$(self)
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
  - id: score_bias
    type:
      - 'null'
      - float
    doc: Score bias when computing SW alignment (in bits)
    inputBinding:
      position: 104
      prefix: --score-bias
  - id: e
    type:
      - 'null'
      - float
    doc: List matches below this E-value (range 0.0-inf)
    inputBinding:
      position: 104
      prefix: -e
  - id: min_seq_id
    type:
      - 'null'
      - float
    doc: List matches above this sequence identity (for clustering) (range 0.0-1.0)
    inputBinding:
      position: 104
      prefix: --min-seq-id
  - id: c
    type:
      - 'null'
      - float
    doc: List matches above this fraction of aligned (covered) residues (see --cov-mode)
    inputBinding:
      position: 104
      prefix: -c
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
  - id: pseudo_cnt_mode
    type:
      - 'null'
      - int
    doc: 'use 0: substitution-matrix or 1: context-specific pseudocounts'
    inputBinding:
      position: 104
      prefix: --pseudo-cnt-mode
  - id: pca
    type:
      - 'null'
      - float
    doc: Pseudo count admixture strength
    inputBinding:
      position: 104
      prefix: --pca
  - id: pcb
    type:
      - 'null'
      - float
    doc: 'Pseudo counts: Neff at half of maximum admixture (range 0.0-inf)'
    inputBinding:
      position: 104
      prefix: --pcb
  - id: filter_min_enable
    type:
      - 'null'
      - int
    doc: Only filter MSAs with more than N sequences, 0 always filters
    inputBinding:
      position: 104
      prefix: --filter-min-enable
  - id: max_seq_id
    type:
      - 'null'
      - float
    doc: Reduce redundancy of output MSA using max. pairwise sequence identity [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --max-seq-id
  - id: qid
    type:
      - 'null'
      - string
    doc: 'Reduce diversity of output MSAs using min.seq. identity with query sequences [0.0,1.0]
      Alternatively, can be a list of multiple thresholds: E.g.: 0.15,0.30,0.50 to defines
      filter buckets of ]0.15-0.30] and ]0.30-0.50]'
    inputBinding:
      position: 104
      prefix: --qid
  - id: qsc
    type:
      - 'null'
      - float
    doc: Reduce diversity of output MSAs using min. score per aligned residue with query sequences
      [-50.0,100.0]
    inputBinding:
      position: 104
      prefix: --qsc
  - id: cov
    type:
      - 'null'
      - float
    doc: Filter output MSAs using min. fraction of query residues covered by matched sequences
      [0.0,1.0]
    inputBinding:
      position: 104
      prefix: --cov
  - id: diff
    type:
      - 'null'
      - int
    doc: Filter MSAs by selecting most diverse set of sequences, keeping at least this many
      seqs in each MSA block of length 50
    inputBinding:
      position: 104
      prefix: --diff
  - id: expansion_mode
    type:
      - 'null'
      - int
    doc: 'Update score, E-value, and sequence identity by 0: input alignment 1: rescoring
      the inferred backtrace'
    inputBinding:
      position: 104
      prefix: --expansion-mode
  - id: expand_filter_clusters
    type:
      - 'null'
      - int
    doc: 'Filter each target cluster during expansion 0: no filter 1: filter'
    inputBinding:
      position: 104
      prefix: --expand-filter-clusters
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 104
      prefix: --max-seq-len
  - id: db_load_mode
    type:
      - 'null'
      - int
    doc: 'Database preload mode 0: auto, 1: fread, 2: mmap, 3: mmap+touch'
    inputBinding:
      position: 104
      prefix: --db-load-mode
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
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
