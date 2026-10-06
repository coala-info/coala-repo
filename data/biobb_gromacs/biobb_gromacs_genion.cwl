cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genion
label: biobb_gromacs_genion
doc: "Wrapper for the GROMACS genion module.\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Properties file. This file can be a YAML file, JSON file or JSON string
    inputBinding:
      position: 1
      prefix: --config
  - id: input_tpr_path
    type: File
    doc: 'Path to the input portable run input TPR file. Accepted formats: tpr.'
    inputBinding:
      position: 1
      prefix: --input_tpr_path
  - id: output_gro_path
    type: string
    doc: 'Path to the input structure GRO file. Accepted formats: gro.'
    default: genion.gro
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
    doc: 'Path the output topology TOP and ITP files zipball. Accepted formats: zip.'
    default: genion_top.zip
    inputBinding:
      position: 1
      prefix: --output_top_zip_path
  - id: input_ndx_path
    type:
      - 'null'
      - File
    doc: 'Path to the input index NDX file. Accepted formats: ndx.'
    inputBinding:
      position: 1
      prefix: --input_ndx_path
outputs:
  - id: gro
    type: File
    doc: 'Path to the input structure GRO file. Accepted formats: gro.'
    outputBinding:
      glob: $(inputs.output_gro_path)
  - id: top_zip
    type: File
    doc: 'Path the output topology TOP and ITP files zipball. Accepted formats: zip.'
    outputBinding:
      glob: $(inputs.output_top_zip_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
