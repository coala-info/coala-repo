cwlVersion: v1.2
class: CommandLineTool
baseCommand: cath-cluster
label: cath-tools_cath-cluster
doc: "Cluster items based on the links between them.\n\nTool homepage: https://github.com/UCLOrengoGroup/cath-tools"
inputs:
  - id: input_file
    type: File
    doc: Input file. When <input_file> is -, the links are read from standard 
      input.
    inputBinding:
      position: 1
  - id: column_idx
    type:
      - 'null'
      - int
    doc: "Parse the link values (distances/strengths) from column number <colnum>\n\
      \                                Must be ≥ 3 because columns 1 and 2 must contain
      the IDs"
    inputBinding:
      position: 102
      prefix: --column-idx
  - id: levels
    type: string
    doc: Cluster at levels <levels>, which is ordered values separated by commas
      (eg 35,60,95,100)
    inputBinding:
      position: 102
      prefix: --levels
  - id: link_dirn
    type: string
    doc: "Interpret each link value as <dirn>, one of: DISTANCE - A higher value means
      the corresponding two entries are more distant\n                           \
      \        STRENGTH - A higher value means the corresponding tow entries are more
      connected"
    inputBinding:
      position: 102
      prefix: --link-dirn
  - id: names_infile
    type:
      - 'null'
      - File
    doc: "[RECOMMENDED] Read names and sorting scores from file <file> (or '-' for
      stdin)"
    inputBinding:
      position: 102
      prefix: --names-infile
outputs:
  - id: clusters_to_file
    type:
      - 'null'
      - File
    doc: Write the clustering to file <file> (or '-' for stdout)
    outputBinding:
      glob: $(inputs.clusters_to_file)
  - id: merges_to_file
    type:
      - 'null'
      - File
    doc: Write the ordered list of merges to file <file> (or '-' for stdout)
    outputBinding:
      glob: $(inputs.merges_to_file)
  - id: clust_spans_to_file
    type:
      - 'null'
      - File
    doc: Write links that form spanning trees for each cluster to file <file> 
      (or '-' for stdout)
    outputBinding:
      glob: $(inputs.clust_spans_to_file)
  - id: reps_to_file
    type:
      - 'null'
      - File
    doc: Write the list of representatives to file <file> (or '-' for stdout)
    outputBinding:
      glob: $(inputs.reps_to_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
