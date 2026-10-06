cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gmxselect
label: biobb_gromacs_gmxselect
doc: "Wrapper for the GROMACS select module.\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Properties file. This file can be a YAML file, JSON file or JSON string
    inputBinding:
      position: 1
      prefix: --config
  - id: input_structure_path
    type: File
    doc: 'Path to the input GRO/PDB/TPR file. Accepted formats: pdb, gro, tpr.'
    inputBinding:
      position: 1
      prefix: --input_structure_path
  - id: output_ndx_path
    type: string
    doc: 'Path to the output index NDX file. Accepted formats: ndx.'
    default: gmxselect.ndx
    inputBinding:
      position: 1
      prefix: --output_ndx_path
  - id: input_ndx_path
    type:
      - 'null'
      - File
    doc: 'Path to the input index NDX file. Accepted formats: ndx.'
    inputBinding:
      position: 1
      prefix: --input_ndx_path
outputs:
  - id: ndx
    type: File
    doc: 'Path to the output index NDX file. Accepted formats: ndx.'
    outputBinding:
      glob: $(inputs.output_ndx_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
