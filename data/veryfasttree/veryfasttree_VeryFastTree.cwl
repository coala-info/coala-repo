cwlVersion: v1.2
class: CommandLineTool
baseCommand: VeryFastTree
label: veryfasttree_VeryFastTree
doc: "VeryFastTree accepts alignments in NEXUS, Fasta, Fastq or Phylip interleaved
  formats compressed with ZLib and libBZ2.\n\nTool homepage: https://github.com/citiususc/veryfasttree"
inputs:
  - id: nucleotide_alignment
    type:
      - 'null'
      - File
    doc: nucleotide alignment file
    inputBinding:
      position: 1
  - id: protein_alignment
    type:
      - 'null'
      - File
    doc: protein alignment file
    inputBinding:
      position: 2
  - id: allow_restricted_chars
    type:
      - 'null'
      - boolean
    doc: allow spaces and other restricted characters (but not ' ) in sequence 
      names and quote names in the output tree (fasta/fastq input only; 
      VeryFastTree will not be able to read these trees back in)
    inputBinding:
      position: 103
      prefix: -quote
  - id: constraint_alignment
    type:
      - 'null'
      - File
    doc: to constrain the topology search constraintAlignment should have 1s or 
      0s to indicates splits
    inputBinding:
      position: 103
      prefix: -constraints
  - id: disable_maximum_likelihood
    type:
      - 'null'
      - boolean
    doc: to turn off maximum-likelihood
    inputBinding:
      position: 103
      prefix: -noml
  - id: disable_min_evolution
    type:
      - 'null'
      - boolean
    doc: to turn off minimum-evolution NNIs and SPRs (recommended if running 
      additional ML NNIs with -intree)
    inputBinding:
      position: 103
      prefix: -nome
  - id: disable_support_values
    type:
      - 'null'
      - boolean
    doc: to not compute support values
    inputBinding:
      position: 103
      prefix: -nosupport
  - id: exclude_slow
    type:
      - 'null'
      - boolean
    doc: 'Excludes: -slow'
    inputBinding:
      position: 103
      prefix: -slow
  - id: expert_mode
    type:
      - 'null'
      - boolean
    doc: see more options
    inputBinding:
      position: 103
      prefix: -expert
  - id: fastest_speedup
    type:
      - 'null'
      - boolean
    doc: speed up the neighbor joining phase & reduce memory usage (recommended 
      for >50,000 sequences)
    inputBinding:
      position: 103
      prefix: -fastest
  - id: log_file
    type:
      - 'null'
      - File
    doc: save intermediate trees, settings, and model details
    inputBinding:
      position: 103
      prefix: -log
  - id: nucleotide_input
    type:
      - 'null'
      - boolean
    doc: for nucleotide alignment input
    inputBinding:
      position: 103
      prefix: -nt
  - id: number_of_alignments
    type:
      - 'null'
      - int
    doc: to analyze multiple alignments (phylip format only) (use for global 
      bootstrap, with seqboot and CompareToBootstrap.pl)
    inputBinding:
      position: 103
      prefix: -n
  - id: optimize_branch_lengths_fixed_topology
    type:
      - 'null'
      - boolean
    doc: with -intree to optimize branch lengths for a fixed topology
    inputBinding:
      position: 103
      prefix: -nome -mllen
  - id: rate_categories
    type:
      - 'null'
      - int
    doc: to specify the number of rate categories of sites (default 20)
    inputBinding:
      position: 103
      prefix: -cat
  - id: rescale_gamma20_likelihood
    type:
      - 'null'
      - boolean
    doc: after optimizing the tree under the CAT approximation, rescale the 
      lengths to optimize the Gamma20 likelihood
    inputBinding:
      position: 103
      prefix: -gamma
  - id: starting_tree
    type:
      - 'null'
      - File
    doc: to set the starting tree(s)
    inputBinding:
      position: 103
      prefix: -intree
  - id: starting_tree_for_all
    type:
      - 'null'
      - File
    doc: to use this starting tree for all the alignments (for faster global 
      bootstrap on huge alignments)
    inputBinding:
      position: 103
      prefix: -intree1
  - id: suppress_progress
    type:
      - 'null'
      - boolean
    doc: to suppress progress indicator
    inputBinding:
      position: 103
      prefix: -nopr
  - id: suppress_reporting
    type:
      - 'null'
      - boolean
    doc: to suppress reporting information
    inputBinding:
      position: 103
      prefix: -quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (n) used in the parallel execution.
    inputBinding:
      position: 103
      prefix: -threads
  - id: use_constant_rates
    type:
      - 'null'
      - boolean
    doc: to use constant rates
    inputBinding:
      position: 103
      prefix: -nocat
  - id: use_double_precision
    type:
      - 'null'
      - boolean
    doc: to use double precision arithmetic. Therefore, it is equivalent to 
      compile FastTree-2 with -DUSE_DOUBLE
    inputBinding:
      position: 103
      prefix: -double-precision
  - id: use_gtr_model
    type:
      - 'null'
      - boolean
    doc: generalized time-reversible model (nucleotide alignments only)
    inputBinding:
      position: 103
      prefix: -gtr
  - id: use_lg_model
    type:
      - 'null'
      - boolean
    doc: Le-Gascuel 2008 model (amino acid alignments only)
    inputBinding:
      position: 103
      prefix: -lg
  - id: use_pseudocounts
    type:
      - 'null'
      - boolean
    doc: to use pseudocounts (recommended for highly gapped sequences)
    inputBinding:
      position: 103
      prefix: -pseudo
  - id: use_wag_model
    type:
      - 'null'
      - boolean
    doc: Whelan-And-Goldman 2001 model (amino acid alignments only)
    inputBinding:
      position: 103
      prefix: -wag
  - id: vector_extensions
    type:
      - 'null'
      - string
    doc: 'to speed up computations enabling the vector extensions. Available: AUTO(default),
      NONE, SSE, SSE3 , AVX, AVX2, AVX512 or CUDA'
    inputBinding:
      position: 103
      prefix: -ext
outputs:
  - id: output_tree
    type:
      - 'null'
      - File
    doc: output tree file
    outputBinding:
      glob: $(inputs.output_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/veryfasttree:4.0.5--h9948957_0
