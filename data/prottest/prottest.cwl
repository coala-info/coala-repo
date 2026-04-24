cwlVersion: v1.2
class: CommandLineTool
baseCommand: prottest3
label: prottest
doc: "ProtTest is a tool for selecting the best-fit model of amino-acid replacement
  for a given set of protein sequences.\n\nTool homepage: https://github.com/ddarriba/prottest3"
inputs:
  - id: aic
    type:
      - 'null'
      - boolean
    doc: Display models sorted by Akaike Information Criterion (AIC)
    inputBinding:
      position: 101
      prefix: -AIC
  - id: aicc
    type:
      - 'null'
      - boolean
    doc: Display models sorted by Corrected Akaike Information Criterion (AICc)
    inputBinding:
      position: 101
      prefix: -AICC
  - id: alignment_file
    type: File
    doc: Alignment input file
    inputBinding:
      position: 101
      prefix: -i
  - id: all_distributions
    type:
      - 'null'
      - boolean
    doc: Include models with rate variation among sites, number of categories 
      and both
    inputBinding:
      position: 101
      prefix: -all-distributions
  - id: all_frameworks
    type:
      - 'null'
      - boolean
    doc: Displays a 7-framework comparison table
    inputBinding:
      position: 101
      prefix: -all
  - id: bic
    type:
      - 'null'
      - boolean
    doc: Display models sorted by Bayesian Information Criterion (BIC)
    inputBinding:
      position: 101
      prefix: -BIC
  - id: consensus_threshold
    type:
      - 'null'
      - float
    doc: Display consensus tree with the specified threshold, between 0.5 and 
      1.0
    inputBinding:
      position: 101
      prefix: -tc
  - id: display_ascii
    type:
      - 'null'
      - boolean
    doc: Display best-model's ASCII tree
    inputBinding:
      position: 101
      prefix: -t2
  - id: display_newick
    type:
      - 'null'
      - boolean
    doc: Display best-model's newick tree
    inputBinding:
      position: 101
      prefix: -t1
  - id: dt
    type:
      - 'null'
      - boolean
    doc: Display models sorted by Decision Theory Criterion
    inputBinding:
      position: 101
      prefix: -DT
  - id: empirical_frequencies
    type:
      - 'null'
      - boolean
    doc: Include models with empirical frequency estimation
    inputBinding:
      position: 101
      prefix: -F
  - id: include_both_i_g
    type:
      - 'null'
      - boolean
    doc: include models with both +I and +G properties
    inputBinding:
      position: 101
      prefix: -IG
  - id: include_invariable
    type:
      - 'null'
      - boolean
    doc: Include models with a proportion of invariable sites
    inputBinding:
      position: 101
      prefix: -I
  - id: include_rate_variation
    type:
      - 'null'
      - boolean
    doc: Include models with rate variation among sites and number of categories
    inputBinding:
      position: 101
      prefix: -G
  - id: log
    type:
      - 'null'
      - string
    doc: Enables / Disables PhyML logging into log directory (enabled/disabled)
    inputBinding:
      position: 101
      prefix: -log
  - id: matrix
    type:
      - 'null'
      - string
    doc: Include matrix (Amino-acid) = JTT LG DCMut MtREV MtMam MtArt Dayhoff 
      WAG RtREV CpREV Blosum62 VT HIVb HIVw FLU. If you don't specify any 
      matrix, all matrices displayed above will be included.
    inputBinding:
      position: 101
      prefix: '-'
  - id: num_categories
    type:
      - 'null'
      - int
    doc: Define number of categories for +G and +I+G models
    inputBinding:
      position: 101
      prefix: -ncat
  - id: optimization_strategy
    type:
      - 'null'
      - int
    doc: 'Optimization strategy mode: 0: Fixed BIONJ JTT, 1: BIONJ Tree, 2: Maximum
      Likelihood tree, 3: User defined topology'
    inputBinding:
      position: 101
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads requested to compute (only if MPJ is not used)
    inputBinding:
      position: 101
      prefix: -threads
  - id: tree_file
    type:
      - 'null'
      - File
    doc: 'Tree file [default: NJ tree]'
    inputBinding:
      position: 101
      prefix: -t
  - id: tree_search_operation
    type:
      - 'null'
      - string
    doc: 'Tree search operation for ML search: NNI (fastest), SPR (slowest), BEST
      (best of NNI and SPR)'
    inputBinding:
      position: 101
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Output file [default: standard output]'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/prottest:v3.4.2dfsg-3-deb_cv1
