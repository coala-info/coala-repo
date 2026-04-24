cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyqi
  - make-command
label: pyqi_make-command
doc: "This command is intended to construct the basics of a Command object so that
  a developer can dive straight into the implementation of the command\n\nTool homepage:
  https://github.com/qir-alliance/pyqir"
inputs:
  - id: author
    type:
      - 'null'
      - string
    doc: author/maintainer name
    inputBinding:
      position: 101
      prefix: --author
  - id: command_version
    type:
      - 'null'
      - string
    doc: version (e.g., 0.1)
    inputBinding:
      position: 101
      prefix: --command-version
  - id: copyright
    type:
      - 'null'
      - string
    doc: copyright (e.g., Copyright 2013, The pyqi project)
    inputBinding:
      position: 101
      prefix: --copyright
  - id: credits
    type:
      - 'null'
      - type: array
        items: string
    doc: comma-separated list of other authors
    inputBinding:
      position: 101
      prefix: --credits
  - id: email
    type:
      - 'null'
      - string
    doc: maintainer email address
    inputBinding:
      position: 101
      prefix: --email
  - id: license
    type:
      - 'null'
      - string
    doc: license (e.g., BSD)
    inputBinding:
      position: 101
      prefix: --license
  - id: name
    type: string
    doc: the name of the Command
    inputBinding:
      position: 101
      prefix: --name
  - id: test_code
    type:
      - 'null'
      - boolean
    doc: create stubbed out unit test code
    inputBinding:
      position: 101
      prefix: --test-code
outputs:
  - id: output_fp
    type: File
    doc: output filepath to store generated Python code
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyqi:0.3.2--py27_1
