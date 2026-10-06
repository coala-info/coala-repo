cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ndx2resttop
label: biobb_gromacs_ndx2resttop
doc: "Generate a restrained topology from an index NDX file.\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Properties file. This file can be a YAML file, JSON file or JSON string
    inputBinding:
      position: 1
      prefix: --config
  - id: input_ndx_path
    type: File
    doc: 'Path to the input NDX index file. Accepted formats: ndx.'
    inputBinding:
      position: 1
      prefix: --input_ndx_path
  - id: input_top_zip_path
    type: File
    doc: 'Path the input TOP topology in zip format. Accepted formats: zip.'
    inputBinding:
      position: 1
      prefix: --input_top_zip_path
  - id: output_top_zip_path
    type: string
    doc: 'Path the output TOP topology in zip format. Accepted formats: zip.'
    default: ndx2resttop_top.zip
    inputBinding:
      position: 1
      prefix: --output_top_zip_path
outputs:
  - id: top_zip
    type: File
    doc: 'Path the output TOP topology in zip format. Accepted formats: zip.'
    outputBinding:
      glob: $(inputs.output_top_zip_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
