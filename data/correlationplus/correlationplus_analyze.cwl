cwlVersion: v1.2
class: CommandLineTool
baseCommand: correlationplus analyze
label: correlationplus_analyze
doc: "A Python package to calculate, visualize and analyze protein correlation maps.\n\
  \nTool homepage: https://github.com/tekpinar/correlationplus"
inputs:
  - id: centrality_type
    type:
      - 'null'
      - string
    doc: 'Type of the centrality that you want to calculate. If you want only a particular
      centrality, you can select one of the following options: degree, betweenness,
      closeness, current_flow_betweenness, current_flow_closeness, eigenvector, community'
    inputBinding:
      position: 101
      prefix: -c
  - id: distance_filter
    type:
      - 'null'
      - float
    doc: Distance filter. The residues with distances higher than this value 
      will be considered as zero.
    inputBinding:
      position: 101
      prefix: -d
  - id: input_correlations
    type: File
    doc: A file containing correlations in matrix format.
    inputBinding:
      position: 101
      prefix: -i
  - id: matrix_type
    type:
      - 'null'
      - string
    doc: Type of the matrix. It can be dcc, ndcc, lmi, nlmi (normalized lmi), 
      absndcc (absolute values of ndcc) or eg (elasticity graph). In addition, 
      coeviz and evcouplings are also some options to analyze sequence 
      correlations. If your data any other coupling data in full matrix format, 
      you can select generic as your data type.
    inputBinding:
      position: 101
      prefix: -t
  - id: pdb_file
    type: File
    doc: PDB file of the protein.
    inputBinding:
      position: 101
      prefix: -p
  - id: value_filter
    type:
      - 'null'
      - float
    doc: Value filter. The values lower than this value in the map will be 
      considered as zero.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: This will be your output file. Output figures are in png format.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/correlationplus:0.2.1--pyh5e36f6f_0
