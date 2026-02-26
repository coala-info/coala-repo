cwlVersion: v1.2
class: CommandLineTool
baseCommand: treetime_mugration
label: treetime_mugration
doc: "Reconstructs discrete ancestral states, for example geographic location, host,
  or similar. In addition to ancestral states, a GTR model of state transitions is
  inferred.\n\nTool homepage: https://github.com/neherlab/treetime"
inputs:
  - id: attribute
    type:
      - 'null'
      - string
    doc: attribute to reconstruct, e.g. country
    inputBinding:
      position: 101
      prefix: --attribute
  - id: confidence
    type:
      - 'null'
      - boolean
    doc: output confidence of mugration inference
    inputBinding:
      position: 101
      prefix: --confidence
  - id: missing_data
    type:
      - 'null'
      - string
    doc: string indicating missing data
    inputBinding:
      position: 101
      prefix: --missing-data
  - id: name_column
    type:
      - 'null'
      - string
    doc: label of the column to be used as taxon name
    inputBinding:
      position: 101
      prefix: --name-column
  - id: pc
    type:
      - 'null'
      - float
    doc: pseudo-counts higher numbers will results in 'flatter' models
    inputBinding:
      position: 101
      prefix: --pc
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: random number generator seed for treetime
    inputBinding:
      position: 101
      prefix: --rng-seed
  - id: sampling_bias_correction
    type:
      - 'null'
      - float
    doc: "a rough estimate of how many more events would have\n                  \
      \      been observed if sequences represented an even sample.\n            \
      \            This should be roughly the (1-sum_i p_i^2)/(1-sum_i\n         \
      \               t_i^2), where p_i are the equilibrium frequencies and\n    \
      \                    t_i are apparent ones.(or rather the time spent in a\n\
      \                        particular state on the tree)"
    inputBinding:
      position: 101
      prefix: --sampling-bias-correction
  - id: states
    type: File
    doc: "csv or tsv file with discrete characters.\n                        #name,country,continent
      taxon1,micronesia,oceania ..."
    inputBinding:
      position: 101
      prefix: --states
  - id: tree
    type: File
    doc: Name of file containing the tree in newick, nexus, or phylip format, 
      the branch length of the tree should be in units of average number of 
      nucleotide or protein substitutions per site. If no file is provided, 
      treetime will attempt to build a tree from the alignment using fasttree, 
      iqtree, or raxml (assuming they are installed).
    inputBinding:
      position: 101
      prefix: --tree
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity of output 0-6
    inputBinding:
      position: 101
      prefix: --verbose
  - id: weights
    type:
      - 'null'
      - File
    doc: "csv or tsv file with probabilities of that a randomly\n                \
      \        sampled sequence at equilibrium has a particular\n                \
      \        state. E.g. population of different continents or\n               \
      \         countries. E.g.: #country,weight micronesia,0.1 ..."
    inputBinding:
      position: 101
      prefix: --weights
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: directory to write the output to
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0
