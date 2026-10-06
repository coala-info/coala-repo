cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - editconf
label: biobb_gromacs_editconf
doc: "Wrapper of the GROMACS gmx editconf module.\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Properties file. This file can be a YAML file, JSON file or JSON string
    inputBinding:
      position: 1
      prefix: --config
  - id: input_gro_path
    type: File
    doc: 'Path to the input GRO file. Accepted formats: gro, pdb.'
    inputBinding:
      position: 1
      prefix: --input_gro_path
  - id: output_gro_path
    type: string
    doc: 'Path to the output GRO file. Accepted formats: pdb, gro.'
    default: editconf.gro
    inputBinding:
      position: 1
      prefix: --output_gro_path
outputs:
  - id: gro
    type: File
    doc: 'Path to the output GRO file. Accepted formats: pdb, gro.'
    outputBinding:
      glob: $(inputs.output_gro_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
