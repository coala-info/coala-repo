cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - acpype_convert_amber_to_gmx
label: biobb_chemistry_acpype_convert_amber_to_gmx
doc: "Wrapper of the ACPYPE tool to convert Amber topology and coordinates to GROMACS
  format.\n\nTool homepage: https://github.com/bioexcel/biobb_chemistry"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file (JSON or YAML)
    inputBinding:
      position: 101
      prefix: --config
  - id: input_crd_path
    type: File
    doc: 'Path to the input coordinates file (AMBER crd). Accepted formats: inpcrd.'
    inputBinding:
      position: 101
      prefix: --input_crd_path
  - id: input_top_path
    type: File
    doc: 'Path to the input topology file (AMBER ParmTop). Accepted formats: top, parmtop,
      prmtop.'
    inputBinding:
      position: 101
      prefix: --input_top_path
  - id: output_path_gro
    type: string
    doc: 'Path to the GRO output file. Accepted formats: gro.'
    inputBinding:
      position: 102
      prefix: --output_path_gro
  - id: output_path_top
    type: string
    doc: 'Path to the TOP output file. Accepted formats: top.'
    inputBinding:
      position: 103
      prefix: --output_path_top
outputs:
  - id: output_gro
    type: File
    doc: Output GROMACS coordinates file (.gro)
    outputBinding:
      glob: $(inputs.output_path_gro)
  - id: output_top
    type: File
    doc: Output GROMACS topology file (.top)
    outputBinding:
      glob: $(inputs.output_path_top)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_chemistry:5.2.0--pyhdfd78af_0
