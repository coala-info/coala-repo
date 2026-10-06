cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - solvate
label: biobb_gromacs_solvate
doc: "Wrapper for the GROMACS solvate module.\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Properties file. This file can be a YAML file, JSON file or JSON string
    inputBinding:
      position: 1
      prefix: --config
  - id: input_solute_gro_path
    type: File
    doc: 'Path to the input GRO file. Accepted formats: gro, pdb.'
    inputBinding:
      position: 1
      prefix: --input_solute_gro_path
  - id: output_gro_path
    type: string
    doc: 'Path to the output GRO file. Accepted formats: gro, pdb.'
    default: solvate.gro
    inputBinding:
      position: 1
      prefix: --output_gro_path
  - id: input_top_zip_path
    type: File
    doc: 'Path the input TOP topology in zip format. Accepted formats: zip.'
    inputBinding:
      position: 1
      prefix: --input_top_zip_path
  - id: output_top_zip_path
    type: string
    doc: 'Path the output topology in zip format. Accepted formats: zip.'
    default: solvate_top.zip
    inputBinding:
      position: 1
      prefix: --output_top_zip_path
  - id: input_solvent_gro_path
    type:
      - 'null'
      - File
    doc: '(spc216.gro) Path to the GRO file containing the structure of the solvent. Accepted formats: gro.'
    inputBinding:
      position: 1
      prefix: --input_solvent_gro_path
outputs:
  - id: gro
    type: File
    doc: 'Path to the output GRO file. Accepted formats: gro, pdb.'
    outputBinding:
      glob: $(inputs.output_gro_path)
  - id: top_zip
    type: File
    doc: 'Path the output topology in zip format. Accepted formats: zip.'
    outputBinding:
      glob: $(inputs.output_top_zip_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
