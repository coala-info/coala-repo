cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coconet
  - cluster
label: coconet-binning_cluster
doc: "Bin contigs using neural network\n\nTool homepage: https://github.com/Puumanamana/CoCoNet"
inputs:
  - id: run_dir
    type: Directory
    doc: "Output directory of an earlier coconet step (it is updated in place)"
    inputBinding:
      position: 101
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default: 5)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Print debugging statements"
    inputBinding:
      position: 101
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Less verbose"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "Only error messages"
    inputBinding:
      position: 101
      prefix: --silent
  - id: continue_run
    type:
      - 'null'
      - boolean
    doc: "Start from last checkpoint. The output directory needs to be the same."
    inputBinding:
      position: 101
      prefix: --continue
  - id: fragment_length
    type:
      - 'null'
      - int
    doc: "Length of contig fragments in bp. Default is half the minimum contig length. (default: -1)"
    inputBinding:
      position: 101
      prefix: --fragment-length
  - id: features
    type:
      - 'null'
      - type: array
        items: string
    doc: "Features for binning (composition, coverage, or both) (default: coverage composition)"
    inputBinding:
      position: 101
      prefix: --features
  - id: max_neighbors
    type:
      - 'null'
      - int
    doc: "Maximum number of neighbors to consider to compute the adjacency matrix. (default: 250)"
    inputBinding:
      position: 101
      prefix: --max-neighbors
  - id: vote_threshold
    type:
      - 'null'
      - float
    doc: "When this parameter is not set, contig-contig edges are computed by summing the probability between all pairwise fragments between them. Otherwise, adopt a voting strategy and sets a hard-threshold on the probability from each pairwise comparison."
    inputBinding:
      position: 101
      prefix: --vote-threshold
  - id: algorithm
    type:
      - 'null'
      - string
    doc: "Algorithm for clustering the contig-contig graph (leiden or spectral). The number of clusters is required if \"spectral\" is chosen. (default: leiden)"
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: theta
    type:
      - 'null'
      - float
    doc: "(leiden) Minimum percent of edges between two contigs to form an edge between them (default: 0.8)"
    inputBinding:
      position: 101
      prefix: --theta
  - id: gamma1
    type:
      - 'null'
      - float
    doc: "(leiden) CPM optimization value for the first run of the Leiden clustering (default: 0.3)"
    inputBinding:
      position: 101
      prefix: --gamma1
  - id: gamma2
    type:
      - 'null'
      - float
    doc: "(leiden) CPM optimization value for the second run of the Leiden clustering (default: 0.4)"
    inputBinding:
      position: 101
      prefix: --gamma2
  - id: n_clusters
    type:
      - 'null'
      - int
    doc: "(spectral clustering) Maximum number of clusters"
    inputBinding:
      position: 101
      prefix: --n-clusters
  - id: recruit_small_contigs
    type:
      - 'null'
      - boolean
    doc: "Salvage short contigs (<2048)"
    inputBinding:
      position: 101
      prefix: --recruit-small-contigs
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.run_dir.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.run_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coconet-binning:1.1.0--py_0
