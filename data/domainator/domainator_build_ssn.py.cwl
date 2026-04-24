cwlVersion: v1.2
class: CommandLineTool
baseCommand: build_ssn.py
label: domainator_build_ssn.py
doc: "Generates Sequence Similarity Networks\n    \nBuild a sequence similarity network
  and do analysis related to that.\n\nTool homepage: https://github.com/nebiolabs/domainator"
inputs:
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: Creates a new metadata column called 'SSN_cluster', replacing that 
      column from the metadata file if already present. Finds clusters by 
      following connectivity, assigns each cluster a distinct integer, based on 
      size rank, bigger clusters get smaller numbers.
    inputBinding:
      position: 101
      prefix: --cluster
  - id: color_by
    type:
      - 'null'
      - string
    doc: Color the points in the output image based on this column of the 
      metadata table.
    inputBinding:
      position: 101
      prefix: --color_by
  - id: color_table
    type:
      - 'null'
      - File
    doc: 'tab separated file with two columns and no header, columns are: annotation,
      hex color. For example: CCDB   cc0000'
    inputBinding:
      position: 101
      prefix: --color_table
  - id: config
    type:
      - 'null'
      - File
    doc: Path to a configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: input
    type: File
    doc: pairwise similarity (or distance) scores. In the network, nodes will be
      derived from row and column names, and edges will be added between pairs 
      of rows and columns meeting the threshold criteria. Format can be 
      tab-separated text, or Domainator hdf5.
    inputBinding:
      position: 101
      prefix: --input
  - id: lb
    type:
      - 'null'
      - float
    doc: exclude all edges with weights less than or equal to this value. This 
      should be >= 0.
    inputBinding:
      position: 101
      prefix: --lb
  - id: metadata
    type:
      - 'null'
      - type: array
        items: File
    doc: tab separated files of sequence metadata.
    inputBinding:
      position: 101
      prefix: --metadata
  - id: mst
    type:
      - 'null'
      - boolean
    doc: If set, then only include edges that are part of the maximum spanning 
      tree of the graph. The clusters will be the same as the full graph, but 
      the intra-cluster connections will be pruned to the minimum necessary to 
      preserve the clusters.
    inputBinding:
      position: 101
      prefix: --mst
  - id: no_cluster_header
    type:
      - 'null'
      - boolean
    doc: If set, then the tsv file will not have a header. Only relevant if 
      --cluster_tsv is set.
    inputBinding:
      position: 101
      prefix: --no_cluster_header
  - id: print_config
    type:
      - 'null'
      - boolean
    doc: 'Print the configuration after applying all other arguments and exit. The
      optional flags customizes the output and are one or more keywords separated
      by comma. The supported flags are: comments, skip_default, skip_null.'
    inputBinding:
      position: 101
      prefix: --print_config
outputs:
  - id: color_table_out
    type:
      - 'null'
      - File
    doc: 'tab separated file with two columns and no header, columns are: annotation,
      hex color. Written after the color table is updated with new colors, for example
      if using --color_by, but not supplying an external color table.'
    outputBinding:
      glob: $(inputs.color_table_out)
  - id: xgmml
    type:
      - 'null'
      - File
    doc: write a cytoscape xgmml file of the projection.
    outputBinding:
      glob: $(inputs.xgmml)
  - id: cluster_tsv
    type:
      - 'null'
      - File
    doc: Path to write a tsv file will mapping each sequence to its cluster. If 
      set, then --cluster is automatically activated. If --no_cluster_header not
      set, then the file will have header contig cluster.
    outputBinding:
      glob: $(inputs.cluster_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.1--pyhdfd78af_0
