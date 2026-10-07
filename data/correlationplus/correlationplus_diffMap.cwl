cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - correlationplus
  - diffMap
label: correlationplus_diffMap
doc: "Plot the difference map of two protein correlation maps (ndcc, nlmi or absndcc).\n\
  \nTool homepage: https://github.com/tekpinar/correlationplus"
inputs:
  - id: input_file1
    type: File
    doc: The first file containing normalized dynamical cross correlations or 
      LMI in matrix format.
    inputBinding:
      position: 101
      prefix: -i
  - id: input_file2
    type: File
    doc: The second file containing normalized dynamical cross correlations or
      LMI in matrix format.
    inputBinding:
      position: 101
      prefix: -j
  - id: pdb_file
    type: File
    doc: PDB file of the protein.
    inputBinding:
      position: 101
      prefix: -p
  - id: pdb_file2
    type:
      - 'null'
      - File
    doc: A second PDB file for the other conformation if residues numbers are 
      not same in two conformations.
    inputBinding:
      position: 101
      prefix: -q
  - id: matrix_type
    type:
      - 'null'
      - string
    doc: It can be ndcc, nlmi or absndcc (absolute values of ndcc). Default 
      value is ndcc.
    inputBinding:
      position: 101
      prefix: -t
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix. Output figures are in png format. Default is 
      diff-map.
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Difference map figures (png) whose names start with the output prefix.
    outputBinding:
      glob: "$(inputs.output_prefix ? inputs.output_prefix : 'diff-map')*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/correlationplus:0.2.1--pyh5e36f6f_0
