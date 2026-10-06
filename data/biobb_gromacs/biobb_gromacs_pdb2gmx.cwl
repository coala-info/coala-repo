cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pdb2gmx
label: biobb_gromacs_pdb2gmx
doc: "Wrapper for the GROMACS pdb2gmx module.\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Properties file. This file can be a YAML file, JSON file or JSON string
    inputBinding:
      position: 1
      prefix: --config
  - id: input_pdb_path
    type: File
    doc: 'Path to the input PDB file. Accepted formats: pdb.'
    inputBinding:
      position: 1
      prefix: --input_pdb_path
  - id: output_gro_path
    type: string
    doc: 'Path to the output GRO file. Accepted formats: gro.'
    default: pdb2gmx.gro
    inputBinding:
      position: 1
      prefix: --output_gro_path
  - id: output_top_zip_path
    type: string
    doc: 'Path the output TOP topology in zip format. Accepted formats: zip.'
    default: pdb2gmx_top.zip
    inputBinding:
      position: 1
      prefix: --output_top_zip_path
outputs:
  - id: gro
    type: File
    doc: 'Path to the output GRO file. Accepted formats: gro.'
    outputBinding:
      glob: $(inputs.output_gro_path)
  - id: top_zip
    type: File
    doc: 'Path the output TOP topology in zip format. Accepted formats: zip.'
    outputBinding:
      glob: $(inputs.output_top_zip_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
