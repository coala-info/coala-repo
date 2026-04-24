cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyqi make-optparse
label: pyqi_make-optparse
doc: "Construct and stub out the basic optparse configuration for a given Command.
  This template provides comments and examples of what to fill in.\n\nTool homepage:
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
  - id: command
    type: string
    doc: an existing Command
    inputBinding:
      position: 101
      prefix: --command
  - id: command_module
    type: string
    doc: the Command source module
    inputBinding:
      position: 101
      prefix: --command-module
  - id: config_version
    type:
      - 'null'
      - string
    doc: version (e.g., 0.1)
    inputBinding:
      position: 101
      prefix: --config-version
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
outputs:
  - id: output_fp
    type: File
    doc: output filepath to store generated optparse Python configuration file
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyqi:0.3.2--py27_1
