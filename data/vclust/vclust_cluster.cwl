cwlVersion: v1.2
class: CommandLineTool
baseCommand: vclust_cluster
label: vclust_cluster
doc: "Cluster genomes based on ANI metrics.\n\nTool homepage: https://github.com/refresh-bio/vclust"
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: "Clustering algorithm [single]\n                               * single:
      Single-linkage (connected component)\n                               * complete:
      Complete-linkage\n                               * uclust: UCLUST\n        \
      \                       * cd-hit: Greedy incremental\n                     \
      \          * set-cover: Greedy set-cover (MMseqs2)\n                       \
      \        * leiden: Leiden algorithm"
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: ani
    type:
      - 'null'
      - float
    doc: Min. ANI (0-1) [0]
    inputBinding:
      position: 101
      prefix: --ani
  - id: gani
    type:
      - 'null'
      - float
    doc: Min. global ANI (0-1) [0]
    inputBinding:
      position: 101
      prefix: --gani
  - id: ids_file
    type: File
    doc: Input file with sequence identifiers (tsv)
    inputBinding:
      position: 101
      prefix: --ids
  - id: input_file
    type: File
    doc: Input file with ANI metrics (tsv)
    inputBinding:
      position: 101
      prefix: --in
  - id: leiden_beta
    type:
      - 'null'
      - float
    doc: Beta parameter for the Leiden algorithm [0.01]
    inputBinding:
      position: 101
      prefix: --leiden-beta
  - id: leiden_iterations
    type:
      - 'null'
      - int
    doc: Number of iterations for the Leiden algorithm [2]
    inputBinding:
      position: 101
      prefix: --leiden-iterations
  - id: leiden_resolution
    type:
      - 'null'
      - float
    doc: Resolution parameter for the Leiden algorithm [0.7]
    inputBinding:
      position: 101
      prefix: --leiden-resolution
  - id: len_ratio
    type:
      - 'null'
      - float
    doc: Min. length ratio between shorter and longer sequence (0-1) [0]
    inputBinding:
      position: 101
      prefix: --len_ratio
  - id: metric
    type:
      - 'null'
      - string
    doc: "Similarity metric for clustering [tani]\n                              \
      \ choices: tani,gani,ani"
    inputBinding:
      position: 101
      prefix: --metric
  - id: num_alns
    type:
      - 'null'
      - int
    doc: Max. number of local alignments between two genomes; 0 means all genome
      pairs are allowed. [0]
    inputBinding:
      position: 101
      prefix: --num_alns
  - id: out_repr
    type:
      - 'null'
      - boolean
    doc: Output a representative genome for each cluster instead of numerical 
      cluster identifiers. The representative genome is selected as the one with
      the longest sequence.
    inputBinding:
      position: 101
      prefix: --out-repr
  - id: qcov
    type:
      - 'null'
      - float
    doc: Min. query coverage/aligned fraction (0-1) [0]
    inputBinding:
      position: 101
      prefix: --qcov
  - id: rcov
    type:
      - 'null'
      - float
    doc: Min. reference coverage/aligned fraction (0-1) [0]
    inputBinding:
      position: 101
      prefix: --rcov
  - id: tani
    type:
      - 'null'
      - float
    doc: Min. total ANI (0-1) [0]
    inputBinding:
      position: 101
      prefix: --tani
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Verbosity level [1]:\n                               0: Errors only\n  \
      \                             1: Info\n                               2: Debug"
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vclust:1.3.1--py311he264feb_1
