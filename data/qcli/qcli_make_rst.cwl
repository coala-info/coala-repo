cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qcli_make_rst
label: qcli_make_rst
doc: "This script will take a qcli script and convert the usage strings and options to generate a documentation .rst file.\n\nTool homepage: https://github.com/bipy/qcli"
inputs:
  - id: input_fps
    type:
      type: array
      items: File
    doc: the input file(s) to generate rst files for
    inputBinding:
      position: 1
      prefix: --input_fps
      itemSeparator: ','
  - id: output_dir
    type: string
    doc: the directory where the resulting rst file(s) should be written
    inputBinding:
      position: 1
      prefix: --output_dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print information during execution -- useful for debugging
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: rst_directory
    type: Directory
    doc: Directory with one .rst file per input script
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qcli:0.1.1--py_3
