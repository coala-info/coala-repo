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
  - id: input_inpcrd_path
    type: File
    doc: Path to the input Amber coordinates file (.inpcrd)
    inputBinding:
      position: 101
      prefix: --input_inpcrd_path
  - id: input_prmtop_path
    type: File
    doc: Path to the input Amber topology file (.prmtop)
    inputBinding:
      position: 101
      prefix: --input_prmtop_path
outputs:
  - id: output_top_path
    type: File
    doc: Path to the output GROMACS topology file (.top)
    outputBinding:
      glob: $(inputs.output_top_path)
  - id: output_itp_path
    type: File
    doc: Path to the output GROMACS itp file (.itp)
    outputBinding:
      glob: $(inputs.output_itp_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_chemistry:5.2.0--pyhdfd78af_0
