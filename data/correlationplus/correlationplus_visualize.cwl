cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - correlationplus
  - visualize
label: correlationplus_visualize
doc: "A Python package to calculate, visualize and analyze protein correlation maps.\n\
  \nTool homepage: https://github.com/tekpinar/correlationplus"
inputs:
  - id: cylinder_radius_scaling
    type:
      - 'null'
      - float
    doc: Cylinder radius scaling coefficient to multiply with the correlation 
      quantity. It can be used to improve tcl and pml outputs to view the 
      interaction strengths properly. Recommended values are between 0.0 and 
      2.0.
    inputBinding:
      position: 101
      prefix: -r
  - id: input_file
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
      correlations. If your data is any other coupling data in full matrix 
      format, you can select your data type as 'generic'.
    default: ndcc
    inputBinding:
      position: 101
      prefix: -t
  - id: max_correlation_value
    type:
      - 'null'
      - float
    doc: Maximal correlation value. Any value equal or lower than this will be 
      projected onto protein structure.
    inputBinding:
      position: 101
      prefix: -x
  - id: max_distance
    type:
      - 'null'
      - float
    doc: If the distance between two C_alpha atoms is bigger than the specified 
      distance, it will be projected onto protein structure.
    default: 0.0
    inputBinding:
      position: 101
      prefix: -d
  - id: min_correlation_value
    type:
      - 'null'
      - float
    doc: Minimal correlation value. Any value equal or greater than this will be
      projected onto protein structure.
    inputBinding:
      position: 101
      prefix: -v
  - id: min_distance
    type:
      - 'null'
      - float
    doc: If the distance between two C_alpha atoms is smaller than the specified
      distance, it will be projected onto protein structure.
    default: 9999.9
    inputBinding:
      position: 101
      prefix: -D
  - id: pdb_file
    type: File
    doc: PDB file of the protein.
    inputBinding:
      position: 101
      prefix: -p
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
