cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plasnet
  - type
label: plasnet_type
doc: "Type the communities of a previously split plasmid graph into subcommunities
  or types\n\nTool homepage: https://github.com/leoisl/plasnet"
inputs:
  - id: communities_pickle
    type: File
    doc: Pickle file describing the communities
    inputBinding:
      position: 1
  - id: distances
    type: File
    doc: Tab-separated file with plasmid distances
    inputBinding:
      position: 2
  - id: output_dir
    type: Directory
    doc: Directory to save the output
    inputBinding:
      position: 3
  - id: distance_threshold
    type:
      - 'null'
      - float
    doc: Distance threshold
    inputBinding:
      position: 104
      prefix: --distance-threshold
  - id: no_vis
    type:
      - 'null'
      - boolean
    doc: Disable visualizations
    inputBinding:
      position: 104
      prefix: --no-vis
  - id: output_type
    type:
      - 'null'
      - string
    doc: Whether to output networks as html visualisations, cytoscape formatted 
      json, or both.
    inputBinding:
      position: 104
      prefix: --output-type
  - id: prev_typing
    type:
      - 'null'
      - string
    doc: Previous subcommunity typing, if it exists.
    inputBinding:
      position: 104
      prefix: --prev_typing
  - id: reclustering_method
    type:
      - 'null'
      - string
    doc: 'unbiased: If including a previous subcommunity typing, all previous and
      new genomes will be reclustered from scratch, ignoring previous typing. biased:
      The asynchronous label propagation will start with the previous typing as initial
      labels. nearest_neighbour: Does not cluster the new genomes, rather, assigns
      type based on the closest neighbour of the previous typing.'
    inputBinding:
      position: 104
      prefix: --reclustering_method
  - id: small_subcommunity_size_threshold
    type:
      - 'null'
      - int
    doc: Subcommunities with size up to this parameter will be joined to 
      neighbouring larger subcommunities
    inputBinding:
      position: 104
      prefix: --small-subcommunity-size-threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasnet:0.7.0--pyhdfd78af_0
stdout: plasnet_type.out
