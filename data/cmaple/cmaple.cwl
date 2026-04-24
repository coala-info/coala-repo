cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmaple
label: cmaple
doc: "CMAPLE: A tool for phylogenetic analysis and tree search, supporting various
  models and branch support assessments.\n\nTool homepage: https://github.com/iqtree/cmaple"
inputs:
  - id: alignment
    type: File
    doc: Specify an input alignment file in PHYLIP, FASTA, or MAPLE format.
    inputBinding:
      position: 101
      prefix: -aln
  - id: alrt
    type:
      - 'null'
      - boolean
    doc: Compute branch supports (aLRT-SH).
    inputBinding:
      position: 101
      prefix: --alrt
  - id: blfix
    type:
      - 'null'
      - boolean
    doc: Keep branch lengths unchanged.
    inputBinding:
      position: 101
      prefix: --blfix
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Set the epsilon value for computing branch supports (aLRT-SH).
    inputBinding:
      position: 101
      prefix: --epsilon
  - id: format
    type:
      - 'null'
      - string
    doc: Set the alignment format (PHYLIP/FASTA/MAPLE).
    inputBinding:
      position: 101
      prefix: --format
  - id: ignore_annotation
    type:
      - 'null'
      - boolean
    doc: Ignore annotations from the input tree.
    inputBinding:
      position: 101
      prefix: --ignore-annotation
  - id: max_subs
    type:
      - 'null'
      - float
    doc: 'Specify the maximum #substitutions per site that CMAPLE is effective.'
    inputBinding:
      position: 101
      prefix: --max-subs
  - id: mean_subs
    type:
      - 'null'
      - float
    doc: 'Specify the mean #substitutions per site that CMAPLE is effective.'
    inputBinding:
      position: 101
      prefix: --mean-subs
  - id: min_blength
    type:
      - 'null'
      - float
    doc: Set the minimum branch length.
    inputBinding:
      position: 101
      prefix: --min-blength
  - id: min_sup_alt
    type:
      - 'null'
      - float
    doc: The min support to be outputted as alternative SPRs.
    inputBinding:
      position: 101
      prefix: --min-sup-alt
  - id: model
    type:
      - 'null'
      - string
    doc: Specify a model name.
    inputBinding:
      position: 101
      prefix: -m
  - id: mut_update
    type:
      - 'null'
      - int
    doc: Set the period to update the substitution rates.
    inputBinding:
      position: 101
      prefix: --mut-update
  - id: no_reroot
    type:
      - 'null'
      - boolean
    doc: Do not reroot the input tree.
    inputBinding:
      position: 101
      prefix: --no-reroot
  - id: num_threads
    type:
      - 'null'
      - string
    doc: Set the number of threads for computing branch supports. Use `-nt AUTO`
      to employ all available CPU cores.
    inputBinding:
      position: 101
      prefix: -nt
  - id: out_alternative_spr
    type:
      - 'null'
      - boolean
    doc: Output alternative SPRs and their supports.
    inputBinding:
      position: 101
      prefix: --out-alternative-spr
  - id: out_format
    type:
      - 'null'
      - string
    doc: Specify the format (MAPLE/PHYLIP/FASTA) to output the alignment with 
      `--out-aln`.
    inputBinding:
      position: 101
      prefix: --out-format
  - id: out_internal
    type:
      - 'null'
      - boolean
    doc: Output IDs of internal nodes.
    inputBinding:
      position: 101
      prefix: --out-internal
  - id: out_mul_tree
    type:
      - 'null'
      - boolean
    doc: Output the tree in multifurcating format.
    inputBinding:
      position: 101
      prefix: --out-mul-tree
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite output files if existing.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: prefix
    type:
      - 'null'
      - string
    doc: Specify a prefix for all output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - string
    doc: Specify the reference genome (FILE,SEQ).
    inputBinding:
      position: 101
      prefix: -ref
  - id: replace_intree
    type:
      - 'null'
      - boolean
    doc: Allow CMAPLE to replace the input tree when computing branch supports.
    inputBinding:
      position: 101
      prefix: --replace-intree
  - id: replicates
    type:
      - 'null'
      - int
    doc: Set the number of replicates for computing branch supports (aLRT-SH).
    inputBinding:
      position: 101
      prefix: --replicates
  - id: search_type
    type:
      - 'null'
      - string
    doc: Set tree search type (FAST/NORMAL/EXHAUSTIVE).
    inputBinding:
      position: 101
      prefix: --search
  - id: seed
    type:
      - 'null'
      - int
    doc: Set a seed number for random generators.
    inputBinding:
      position: 101
      prefix: --seed
  - id: seq_type
    type:
      - 'null'
      - string
    doc: Specify a sequence type (DNA/AA).
    inputBinding:
      position: 101
      prefix: -st
  - id: shallow_search
    type:
      - 'null'
      - boolean
    doc: Perform a shallow tree search before a deeper tree search.
    inputBinding:
      position: 101
      prefix: --shallow-search
  - id: sprta
    type:
      - 'null'
      - boolean
    doc: Compute SPRTA supports.
    inputBinding:
      position: 101
      prefix: --sprta
  - id: thresh_opt_diff_fac
    type:
      - 'null'
      - float
    doc: A relative factor to determine whether SPRs are close to the optimal 
      one.
    inputBinding:
      position: 101
      prefix: --thresh-opt-diff-fac
  - id: thresh_prob
    type:
      - 'null'
      - float
    doc: Specify a parameter for approximations.
    inputBinding:
      position: 101
      prefix: --thresh-prob
  - id: tree_file
    type:
      - 'null'
      - File
    doc: Specify a starting tree for tree search.
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - string
    doc: Set the verbose mode (QUIET/MIN/MED/MAX/DEBUG).
    inputBinding:
      position: 101
      prefix: -v
  - id: zero_branch_supp
    type:
      - 'null'
      - boolean
    doc: Compute supports for zero-length branches.
    inputBinding:
      position: 101
      prefix: --zero-branch-supp
outputs:
  - id: out_aln
    type:
      - 'null'
      - File
    doc: Write the input alignment to a file in MAPLE (default), PHYLIP, or 
      FASTA format.
    outputBinding:
      glob: $(inputs.out_aln)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmaple:1.1.0--h503566f_1
