cwlVersion: v1.2
class: CommandLineTool
baseCommand: cl1
label: clusterone
doc: "ClusterONE (Clustering with Overlapping Neighborhood Expansion) is a tool for
  detecting overlapping protein complexes or functional modules in protein-protein
  interaction networks.\n\nTool homepage: https://paccanarolab.org/cluster-one/"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: turns on the debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: fluff
    type:
      - 'null'
      - boolean
    doc: fluffs the clusters
    inputBinding:
      position: 101
      prefix: --fluff
  - id: haircut
    type:
      - 'null'
      - float
    doc: specifies the haircut threshold for clusters
    inputBinding:
      position: 101
      prefix: --haircut
  - id: input_format
    type:
      - 'null'
      - string
    doc: specifies the format of the input file (sif or edge_list)
    inputBinding:
      position: 101
      prefix: --input-format
  - id: k_core
    type:
      - 'null'
      - int
    doc: specifies the minimum k-core index of clusters
    inputBinding:
      position: 101
      prefix: --k-core
  - id: max_overlap
    type:
      - 'null'
      - float
    doc: specifies the maximum allowed overlap between two clusters
    inputBinding:
      position: 101
      prefix: --max-overlap
  - id: merge_method
    type:
      - 'null'
      - string
    doc: specifies the cluster merging method to use (single or multi)
    inputBinding:
      position: 101
      prefix: --merge-method
  - id: min_density
    type:
      - 'null'
      - float
    doc: 'specifies the minimum density of clusters (default: auto)'
    inputBinding:
      position: 101
      prefix: --min-density
  - id: min_size
    type:
      - 'null'
      - int
    doc: specifies the minimum size of clusters
    inputBinding:
      position: 101
      prefix: --min-size
  - id: no_fluff
    type:
      - 'null'
      - boolean
    doc: don't fluff the clusters (default)
    inputBinding:
      position: 101
      prefix: --no-fluff
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: don't merge highly overlapping clusters
    inputBinding:
      position: 101
      prefix: --no-merge
  - id: output_format
    type:
      - 'null'
      - string
    doc: specifies the format of the output file (plain, genepro or csv)
    inputBinding:
      position: 101
      prefix: --output-format
  - id: penalty
    type:
      - 'null'
      - float
    doc: set the node penalty value
    inputBinding:
      position: 101
      prefix: --penalty
  - id: seed_method
    type:
      - 'null'
      - string
    doc: specifies the seed generation method to use
    inputBinding:
      position: 101
      prefix: --seed-method
  - id: similarity
    type:
      - 'null'
      - string
    doc: specifies the similarity function to use (match, simpson, jaccard or 
      dice)
    inputBinding:
      position: 101
      prefix: --similarity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterone:1.0--hdfd78af_0
stdout: clusterone.out
