cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - align
label: mmseqs2_align
doc: 'Optimal gapped local alignment of the prefilter hits of a query database against a target
  database.


  By Martin Steinegger <martin.steinegger@snu.ac.kr> & Maria Hauser


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
    doc: Prefilter result database
    inputBinding:
      position: 3
      valueFrom: $(self.path)/$(inputs.result_db_name)
  - id: result_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_alignment_db_name
    type: string
    doc: Name (prefix) of the output alignment database, written inside the output directory
    inputBinding:
      position: 4
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
  - id: add_self_matches
    type:
      - 'null'
      - int
    doc: Artificially add entries of queries with themselves (for clustering) (0 or 1)
    inputBinding:
      position: 104
      prefix: --add-self-matches
  - id: a
    type:
      - 'null'
      - int
    doc: Add backtrace string (convert to alignments with mmseqs convertalis module) (0 or
      1)
    inputBinding:
      position: 104
      prefix: -a
  - id: alignment_mode
    type:
      - 'null'
      - int
    doc: 'How to compute the alignment: 0: automatic 1: only score and end_pos 2: also start_pos
      and cov 3: also seq.id'
    inputBinding:
      position: 104
      prefix: --alignment-mode
  - id: alignment_output_mode
    type:
      - 'null'
      - int
    doc: 'How to compute the alignment: 0: automatic 1: only score and end_pos 2: also start_pos
      and cov 3: also seq.id 4: only ungapped alignment 5: score only (output) cluster format'
    inputBinding:
      position: 104
      prefix: --alignment-output-mode
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
  - id: alt_ali
    type:
      - 'null'
      - int
    doc: Show up to this many alternative alignments
    inputBinding:
      position: 104
      prefix: --alt-ali
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
  - id: max_rejected
    type:
      - 'null'
      - int
    doc: Maximum rejected alignments before alignment calculation for a query is stopped
    inputBinding:
      position: 104
      prefix: --max-rejected
  - id: max_accept
    type:
      - 'null'
      - int
    doc: Maximum accepted alignments before alignment calculation for a query is stopped
    inputBinding:
      position: 104
      prefix: --max-accept
  - id: score_bias
    type:
      - 'null'
      - float
    doc: Score bias when computing SW alignment (in bits)
    inputBinding:
      position: 104
      prefix: --score-bias
  - id: realign
    type:
      - 'null'
      - int
    doc: Compute more conservative, shorter alignments (scores and E-values not changed) (0
      or 1)
    inputBinding:
      position: 104
      prefix: --realign
  - id: realign_score_bias
    type:
      - 'null'
      - float
    doc: Additional bias when computing realignment
    inputBinding:
      position: 104
      prefix: --realign-score-bias
  - id: realign_max_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of results to return in realignment
    inputBinding:
      position: 104
      prefix: --realign-max-seqs
  - id: corr_score_weight
    type:
      - 'null'
      - float
    doc: Weight of backtrace correlation score that is added to the alignment score
    inputBinding:
      position: 104
      prefix: --corr-score-weight
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
  - id: zdrop
    type:
      - 'null'
      - int
    doc: Maximal allowed difference between score values before alignment is truncated  (nucleotide
      alignment only)
    inputBinding:
      position: 104
      prefix: --zdrop
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
