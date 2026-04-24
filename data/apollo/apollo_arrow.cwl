cwlVersion: v1.2
class: CommandLineTool
baseCommand: arrow
label: apollo_arrow
doc: "Command line wrappers around Apollo functions. While this sounds unexciting,
  with arrow and jq you can easily build powerful command line scripts.\n\nTool homepage:
  https://github.com/galaxy-genome-annotation/python-apollo"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (e.g., init, annotations, organisms, etc.)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the subcommand
    inputBinding:
      position: 2
  - id: apollo_instance
    type: string
    doc: name of apollo instance from /user/qianghu/.apollo-arrow.yml
    inputBinding:
      position: 103
      prefix: --apollo_instance
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level (debug|info|warn|error|critical)
    inputBinding:
      position: 103
      prefix: --log-level
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enables verbose mode.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apollo:4.2.13--pyh5e36f6f_0
stdout: apollo_arrow.out
