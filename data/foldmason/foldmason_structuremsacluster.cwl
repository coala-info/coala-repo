cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - foldmason
  - structuremsacluster
label: foldmason_structuremsacluster
doc: 'Compute a structure-based multiple sequence alignment of the members of one
  cluster of a database.


  By Cameron Gilchrist <gamcil@snu.ac.kr> & Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/steineggerlab/foldmason'
inputs:
  - id: query_db
    type: Directory
    doc: Input structure database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.query_db_name)
  - id: query_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index,
      db.dbtype, db_h, db_ss, db_ca
  - id: cluster_db
    type: Directory
    doc: Cluster database
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.cluster_db_name)
  - id: cluster_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index,
      db.dbtype, db_h, db_ss, db_ca
  - id: alignment_prefix
    type: string
    doc: Output prefix; the tool writes PREFIX_aa.fa, PREFIX_3di.fa and the guide
      tree PREFIX.nw
    inputBinding:
      position: 3
  - id: bitfactor_3di
    type:
      - 'null'
      - float
    doc: 3Di matrix bit factor
    inputBinding:
      position: 104
      prefix: --bitfactor-3di
  - id: bitfactor_aa
    type:
      - 'null'
      - float
    doc: AA matrix bit factor
    inputBinding:
      position: 104
      prefix: --bitfactor-aa
  - id: comp_bias_corr
    type:
      - 'null'
      - int
    doc: Correct for locally biased amino acid composition (range 0-1)
    inputBinding:
      position: 104
      prefix: --comp-bias-corr
  - id: diff
    type:
      - 'null'
      - int
    doc: Filter MSAs by selecting most diverse set of sequences, keeping at least
      this many seqs in each MSA block of length 50
    inputBinding:
      position: 104
      prefix: --diff
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Fast mode, disable residue neighbourhood similarity scoring
    inputBinding:
      position: 104
      prefix: --fast
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
  - id: guide_tree
    type:
      - 'null'
      - string
    doc: Guide tree in Newick format
    inputBinding:
      position: 104
      prefix: --guide-tree
  - id: mask_profile
    type:
      - 'null'
      - int
    doc: Mask query sequence of profile using tantan [0,1]
    inputBinding:
      position: 104
      prefix: --mask-profile
  - id: match_ratio
    type:
      - 'null'
      - float
    doc: Columns that have a residue in this ratio of all sequences are kept
    inputBinding:
      position: 104
      prefix: --match-ratio
  - id: max_seq_len
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 104
      prefix: --max-seq-len
  - id: nb_ang_cut
    type:
      - 'null'
      - float
    doc: Maximum distance cutoff (angstrom) for neighboring residues
    inputBinding:
      position: 104
      prefix: --nb-ang-cut
  - id: nb_low_cut
    type:
      - 'null'
      - float
    doc: Minimum neighborhood score threshold
    inputBinding:
      position: 104
      prefix: --nb-low-cut
  - id: nb_multiplier
    type:
      - 'null'
      - float
    doc: Neighborhood score multiplier
    inputBinding:
      position: 104
      prefix: --nb-multiplier
  - id: nb_sigma
    type:
      - 'null'
      - float
    doc: Neighborhood score decay constant
    inputBinding:
      position: 104
      prefix: --nb-sigma
  - id: only_scoring_cols
    type:
      - 'null'
      - boolean
    doc: Normalise LDDT by no. scoring columns
    inputBinding:
      position: 104
      prefix: --only-scoring-cols
  - id: pair_threshold
    type:
      - 'null'
      - float
    doc: '% of pair subalignments with LDDT information [0.0,1.0]'
    inputBinding:
      position: 104
      prefix: --pair-threshold
  - id: pseudo_cnt_mode
    type:
      - 'null'
      - int
    doc: 'use 0: substitution-matrix or 1: context-specific pseudocounts'
    inputBinding:
      position: 104
      prefix: --pseudo-cnt-mode
  - id: qsc
    type:
      - 'null'
      - float
    doc: Reduce diversity of output MSAs using min. score per aligned residue with
      query sequences [-50.0,100.0]
    inputBinding:
      position: 104
      prefix: --qsc
  - id: recompute_scores
    type:
      - 'null'
      - boolean
    doc: Recompute all-vs-all alignment scores every iteration
    inputBinding:
      position: 104
      prefix: --recompute-scores
  - id: refine_iters
    type:
      - 'null'
      - int
    doc: Number of alignment refinement iterations
    inputBinding:
      position: 104
      prefix: --refine-iters
  - id: refine_seed
    type:
      - 'null'
      - int
    doc: Random number generator seed
    inputBinding:
      position: 104
      prefix: --refine-seed
  - id: score_bias_pssm
    type:
      - 'null'
      - float
    doc: PSSM score bias
    inputBinding:
      position: 104
      prefix: --score-bias-pssm
  - id: sub_mat
    type:
      - 'null'
      - string
    doc: Substitution matrix file
    inputBinding:
      position: 104
      prefix: --sub-mat
  - id: sw_gap_extend
    type:
      - 'null'
      - int
    doc: Gap extension cost for all-vs-all Smith-Waterman alignment
    inputBinding:
      position: 104
      prefix: --sw-gap-extend
  - id: sw_gap_open
    type:
      - 'null'
      - int
    doc: Gap open cost for all-vs-all Smith-Waterman alignment
    inputBinding:
      position: 104
      prefix: --sw-gap-open
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
  - id: wg
    type:
      - 'null'
      - int
    doc: Use global sequence weighting for profile calculation (0 or 1)
    inputBinding:
      position: 104
      prefix: --wg
outputs:
  - id: alignment_aa
    type: File
    doc: Amino acid multiple sequence alignment (FASTA)
    outputBinding:
      glob: $(inputs.alignment_prefix)_aa.fa
  - id: alignment_3di
    type: File
    doc: 3Di multiple sequence alignment (FASTA)
    outputBinding:
      glob: $(inputs.alignment_prefix)_3di.fa
  - id: guide_tree
    type: File
    doc: Guide tree in Newick format
    outputBinding:
      glob: $(inputs.alignment_prefix).nw
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
