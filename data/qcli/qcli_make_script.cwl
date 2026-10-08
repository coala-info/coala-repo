cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qcli_make_script
label: qcli_make_script
doc: "This script will create a template qcli script and make it executable.\n\nTool homepage: https://github.com/bipy/qcli"
inputs:
  - id: output_fp
    type: string
    doc: The output filepath.
    inputBinding:
      position: 1
      prefix: --output_fp
  - id: author_name
    type:
      - 'null'
      - string
    doc: The script author's name to be included in the header variables.
    inputBinding:
      position: 1
      prefix: --author_name
  - id: author_email
    type:
      - 'null'
      - string
    doc: The script author's e-mail address to be included in the header variables.
    inputBinding:
      position: 1
      prefix: --author_email
  - id: copyright
    type:
      - 'null'
      - string
    doc: The copyright information to be included in the header variables. [default:Copyright 2013, The BiPy project]
    inputBinding:
      position: 1
      prefix: --copyright
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print information during execution -- useful for debugging
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: script
    type: File
    doc: The template qcli script
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qcli:0.1.1--py_3
