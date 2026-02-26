cwlVersion: v1.2
class: CommandLineTool
baseCommand: magus
label: magus-msa_magus
doc: "MAGUS is a tool for multiple sequence alignment.\n\nTool homepage: https://github.com/vlasmirnov/MAGUS"
inputs:
  - id: align_size_limit
    type:
      - 'null'
      - string
    doc: Size threshold for alignment compression (in GB)
    inputBinding:
      position: 101
      prefix: --alignsizelimit
  - id: backbones
    type:
      - 'null'
      - type: array
        items: File
    doc: Paths to input backbone alignment files
    inputBinding:
      position: 101
      prefix: --backbones
  - id: constrain
    type:
      - 'null'
      - boolean
    doc: "Constrain MAGUS to respect subalignments (true or\n                    \
      \    false)"
    inputBinding:
      position: 101
      prefix: --constrain
  - id: data_type
    type:
      - 'null'
      - string
    doc: "Data type (dna, rna, or protein). Will be inferred if\n                \
      \        not provided"
    inputBinding:
      position: 101
      prefix: --datatype
  - id: decomp_skeleton_size
    type:
      - 'null'
      - int
    doc: "Number of skeleton sequences for the initial\n                        decomposition
      strategy"
    inputBinding:
      position: 101
      prefix: --decompskeletonsize
  - id: decomp_strategy
    type:
      - 'null'
      - string
    doc: Initial decomposition strategy (pastastyle or kmh)
    inputBinding:
      position: 101
      prefix: --decompstrategy
  - id: graph_build_hmm_extend
    type:
      - 'null'
      - boolean
    doc: "Extend the alignment graph MAFFT backbones with hmmer\n                \
      \        (true or false)"
    inputBinding:
      position: 101
      prefix: --graphbuildhmmextend
  - id: graph_build_method
    type:
      - 'null'
      - string
    doc: "Method for building the alignment graph (mafft,\n                      \
      \  mafftmerge, or initial)"
    inputBinding:
      position: 101
      prefix: --graphbuildmethod
  - id: graph_build_restrict
    type:
      - 'null'
      - boolean
    doc: "Prevent the alignment graph from adding edges that\n                   \
      \     violate subalignments (true or false)"
    inputBinding:
      position: 101
      prefix: --graphbuildrestrict
  - id: graph_cluster_method
    type:
      - 'null'
      - string
    doc: "Method for initial clustering of the alignment graph\n                 \
      \       (mcl or none)"
    inputBinding:
      position: 101
      prefix: --graphclustermethod
  - id: graph_trace_method
    type:
      - 'null'
      - string
    doc: "Method for finding a trace from the alignment graph\n                  \
      \      (minclusters, fm, mwtgreedy, or mwtsearch)"
    inputBinding:
      position: 101
      prefix: --graphtracemethod
  - id: graph_trace_optimize
    type:
      - 'null'
      - boolean
    doc: "Run an optimization step on the graph trace (true or\n                 \
      \       false)"
    inputBinding:
      position: 101
      prefix: --graphtraceoptimize
  - id: guidetree
    type:
      - 'null'
      - string
    doc: "Guide tree for subset decomposition. fasttree\n                        (default),
      fasttree-noml, clustal, parttree, or path\n                        to user guide
      tree"
    default: fasttree
    inputBinding:
      position: 101
      prefix: --guidetree
  - id: inflation_factor
    type:
      - 'null'
      - float
    doc: MCL inflation factor
    inputBinding:
      position: 101
      prefix: --inflationfactor
  - id: mafft_runs
    type:
      - 'null'
      - int
    doc: Number of MAFFT runs
    inputBinding:
      position: 101
      prefix: --mafftruns
  - id: mafft_size
    type:
      - 'null'
      - int
    doc: Maximum size of MAFFT alignments
    inputBinding:
      position: 101
      prefix: --mafftsize
  - id: max_num_subsets
    type:
      - 'null'
      - int
    doc: Maximum number of subsets for divide-and-conquer
    inputBinding:
      position: 101
      prefix: --maxnumsubsets
  - id: max_subset_size
    type:
      - 'null'
      - int
    doc: Maximum subset size for divide-and-conquer
    inputBinding:
      position: 101
      prefix: --maxsubsetsize
  - id: numprocs
    type:
      - 'null'
      - int
    doc: "Number of processors to use (default: # cpus\n                        available)"
    inputBinding:
      position: 101
      prefix: --numprocs
  - id: only_guide_tree
    type:
      - 'null'
      - boolean
    doc: Only output the guide tree (true or false)
    inputBinding:
      position: 101
      prefix: --onlyguidetree
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Force overwriting of output files, even if they\n                      \
      \  already exist. Default off."
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: recurse
    type:
      - 'null'
      - boolean
    doc: "Allow MAGUS to recurse on large subsets (true or\n                     \
      \   false)"
    inputBinding:
      position: 101
      prefix: --recurse
  - id: recurse_guide_tree
    type:
      - 'null'
      - string
    doc: "If recursing, passes this argument as the guide tree\n                 \
      \       option to the lower levels. (Default fasttree)"
    default: fasttree
    inputBinding:
      position: 101
      prefix: --recurseguidetree
  - id: recurse_threshold
    type:
      - 'null'
      - int
    doc: "MAGUS will recursively align subsets above this\n                      \
      \  threshold size"
    inputBinding:
      position: 101
      prefix: --recursethreshold
  - id: sequences
    type: File
    doc: Path to input unaligned sequences
    inputBinding:
      position: 101
      prefix: --sequences
  - id: subalignments
    type:
      - 'null'
      - type: array
        items: File
    doc: Paths to input subalignment files
    inputBinding:
      position: 101
      prefix: --subalignments
  - id: working_directory
    type:
      - 'null'
      - Directory
    doc: Path to working directory
    inputBinding:
      position: 101
      prefix: --directory
outputs:
  - id: output
    type: File
    doc: "Output alignment path. Will be set to /dev/stdout if\n                 \
      \       '-' is passed."
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magus-msa:0.2.0--pyhdfd78af_0
