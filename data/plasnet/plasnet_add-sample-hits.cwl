cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - plasnet
  - add-sample-hits
label: plasnet_add-sample-hits
doc: "Add sample hits annotations on top of previously identified subcommunities or
  types\n\nTool homepage: https://github.com/leoisl/plasnet"
inputs:
  - id: subcommunities_pickle
    type: File
    doc: Pickle file describing the subcommunities
    inputBinding:
      position: 1
  - id: sample_hits
    type: File
    doc: 'Tab-separated file with 2 columns: sample, plasmid. Identifies the plasmids
      present in each sample.'
    inputBinding:
      position: 2
  - id: output_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 3
  - id: output_type
    type:
      - 'null'
      - string
    doc: Whether to output networks as html visualisations, cytoscape formatted 
      json, or both.
    inputBinding:
      position: 104
      prefix: --output-type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasnet:0.7.0--pyhdfd78af_0
stdout: plasnet_add-sample-hits.out
