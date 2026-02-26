cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhmake
label: hhsuite_hhmake
doc: "Build an HMM from an input alignment in A2M, A3M, or FASTA format, or convert
  between HMMER format (.hmm) and HHsearch format (.hhm).\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs:
  - id: alignment_format
    type:
      - 'null'
      - string
    doc: "use A2M/A3M (default): upper case = Match; lower case = Insert; '-' = Delete;
      '.' = gaps aligned to inserts (may be omitted)"
    default: a2m
    inputBinding:
      position: 101
      prefix: -M
  - id: alignment_format_first
    type:
      - 'null'
      - boolean
    doc: 'use FASTA: columns with residue in 1st sequence are match states'
    inputBinding:
      position: 101
      prefix: -M
  - id: alignment_format_gap_percentage
    type:
      - 'null'
      - float
    doc: 'use FASTA: columns with fewer than X% gaps are match states'
    inputBinding:
      position: 101
      prefix: -M
  - id: append_hmm_file
    type:
      - 'null'
      - File
    doc: HMM file to be appended to
    inputBinding:
      position: 101
      prefix: -a
  - id: context_file
    type:
      - 'null'
      - File
    doc: context file for computing context-specific pseudocounts
    inputBinding:
      position: 101
      prefix: -contxt
  - id: filter_diverse_sequences
    type:
      - 'null'
      - int
    doc: filter MSA by selecting most diverse set of sequences, keeping at least
      this many seqs in each MSA block of length 50
    default: 100
    inputBinding:
      position: 101
      prefix: -diff
  - id: hmm_name
    type:
      - 'null'
      - string
    doc: 'use this name for HMM (default: use name of first sequence)'
    inputBinding:
      position: 101
      prefix: -name
  - id: input_alignment
    type: File
    doc: query alignment (A2M, A3M, or FASTA), or query HMM
    inputBinding:
      position: 101
      prefix: -i
  - id: make_consensus_master
    type:
      - 'null'
      - boolean
    doc: make consensus sequence master sequence of query MSA
    inputBinding:
      position: 101
      prefix: -add_cons
  - id: max_hmm_columns
    type:
      - 'null'
      - int
    doc: max number of HMM columns
    default: 20001
    inputBinding:
      position: 101
      prefix: -maxres
  - id: max_input_rows
    type:
      - 'null'
      - int
    doc: max number of input rows
    default: 65535
    inputBinding:
      position: 101
      prefix: -maxseq
  - id: max_pairwise_identity
    type:
      - 'null'
      - float
    doc: maximum pairwise sequence identity (%)
    default: 90
    inputBinding:
      position: 101
      prefix: -id
  - id: max_query_template_sequences
    type:
      - 'null'
      - int
    doc: max. number of query/template sequences displayed
    default: 10
    inputBinding:
      position: 101
      prefix: -seq
  - id: min_coverage_with_query
    type:
      - 'null'
      - float
    doc: minimum coverage with query (%)
    default: 0
    inputBinding:
      position: 101
      prefix: -cov
  - id: min_score_per_column_with_query
    type:
      - 'null'
      - float
    doc: minimum score per column with query
    default: -20.0
    inputBinding:
      position: 101
      prefix: -qsc
  - id: min_sequence_identity_with_query
    type:
      - 'null'
      - float
    doc: minimum sequence identity with query (%)
    default: 0
    inputBinding:
      position: 101
      prefix: -qid
  - id: pc_hhm_contxt_a
    type:
      - 'null'
      - float
    doc: overall pseudocount admixture (def=0.9)
    default: 0.9
    inputBinding:
      position: 101
      prefix: -pc_hhm_contxt_a
  - id: pc_hhm_contxt_b
    type:
      - 'null'
      - float
    doc: Neff threshold value for mode 2 (def=4.0)
    default: 4.0
    inputBinding:
      position: 101
      prefix: -pc_hhm_contxt_b
  - id: pc_hhm_contxt_c
    type:
      - 'null'
      - float
    doc: extinction exponent c for mode 2 (def=1.0)
    default: 1.0
    inputBinding:
      position: 101
      prefix: -pc_hhm_contxt_c
  - id: pc_hhm_contxt_mode
    type:
      - 'null'
      - int
    doc: position dependence of pc admixture 'tau' (pc mode, default=0)
    default: 0
    inputBinding:
      position: 101
      prefix: -pc_hhm_contxt_mode
  - id: pc_hhm_nocontxt_a
    type:
      - 'null'
      - float
    doc: overall pseudocount admixture (def=1.0)
    default: 1.0
    inputBinding:
      position: 101
      prefix: -pc_hhm_nocontxt_a
  - id: pc_hhm_nocontxt_b
    type:
      - 'null'
      - float
    doc: Neff threshold value for mode 2 (def=1.5)
    default: 1.5
    inputBinding:
      position: 101
      prefix: -pc_hhm_nocontxt_b
  - id: pc_hhm_nocontxt_c
    type:
      - 'null'
      - float
    doc: extinction exponent c for mode 2 (def=1.0)
    default: 1.0
    inputBinding:
      position: 101
      prefix: -pc_hhm_nocontxt_c
  - id: pc_hhm_nocontxt_mode
    type:
      - 'null'
      - int
    doc: position dependence of pc admixture 'tau' (pc mode, default=2)
    default: 2
    inputBinding:
      position: 101
      prefix: -pc_hhm_nocontxt_mode
  - id: target_diversity
    type:
      - 'null'
      - float
    doc: target diversity of alignment (default=off)
    inputBinding:
      position: 101
      prefix: -neff
  - id: use_substitution_matrix
    type:
      - 'null'
      - boolean
    doc: use substitution-matrix instead of context-specific pseudocounts
    inputBinding:
      position: 101
      prefix: -nocontxt
  - id: verbose_mode
    type:
      - 'null'
      - int
    doc: 'verbose mode: 0:no screen output  1:only warings  2: verbose'
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_hmm_file
    type: File
    doc: HMM file to be written to
    outputBinding:
      glob: $(inputs.output_hmm_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
