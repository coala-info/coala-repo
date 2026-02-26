cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plasnet
  - split
label: plasnet_split
doc: "Creates and split a plasmid graph into communities\n\nTool homepage: https://github.com/leoisl/plasnet"
inputs:
  - id: plasmids
    type: File
    doc: Plasmids file
    inputBinding:
      position: 1
  - id: distances
    type: File
    doc: Distances file
    inputBinding:
      position: 2
  - id: output_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 3
  - id: bh_connectivity
    type:
      - 'null'
      - int
    doc: Minimum number of connections a plasmid need to be considered a hub 
      plasmid
    inputBinding:
      position: 104
      prefix: --bh-connectivity
  - id: bh_neighbours_edge_density
    type:
      - 'null'
      - float
    doc: Maximum number of edge density between hub plasmid neighbours to label 
      the plasmid as hub
    inputBinding:
      position: 104
      prefix: --bh-neighbours-edge-density
  - id: distance_threshold
    type:
      - 'null'
      - float
    doc: Distance threshold
    inputBinding:
      position: 104
      prefix: --distance-threshold
  - id: graph_pickle
    type:
      - 'null'
      - File
    doc: Existing plasmid graph to append new plasmids to.
    inputBinding:
      position: 104
      prefix: --graph-pickle
  - id: no_community_vis
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 104
      prefix: --no-community-vis
  - id: output_plasmid_graph
    type:
      - 'null'
      - boolean
    doc: Also outputs the full, unsplit, plasmid graph
    inputBinding:
      position: 104
      prefix: --output-plasmid-graph
  - id: output_type
    type:
      - 'null'
      - string
    doc: Whether to output networks as html visualisations, cytoscape formatted 
      json, or both.
    inputBinding:
      position: 104
      prefix: --output-type
  - id: plasmids_metadata
    type:
      - 'null'
      - File
    doc: Plasmids metadata text file.
    inputBinding:
      position: 104
      prefix: --plasmids-metadata
  - id: prev_typing
    type:
      - 'null'
      - string
    doc: Previous community typing, if appending to an existing plasmid graph.
    inputBinding:
      position: 104
      prefix: --prev_typing
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasnet:0.7.0--pyhdfd78af_0
stdout: plasnet_split.out
