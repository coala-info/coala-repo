cwlVersion: v1.2
class: CommandLineTool
baseCommand: eider
label: eider_generate-completion
doc: "Bash completion support for the `eider` command\n\nTool homepage: https://github.com/heuermh/eider"
inputs:
  - id: subcommand
    type:
      - 'null'
      - string
    doc: Subcommand to execute
    inputBinding:
      position: 1
  - id: parameters
    type:
      - 'null'
      - string
    doc: Parameters for the query
    inputBinding:
      position: 102
      prefix: --parameters
  - id: preserve_whitespace
    type:
      - 'null'
      - boolean
    doc: Preserve whitespace
    inputBinding:
      position: 102
      prefix: --preserve-whitespace
  - id: query
    type:
      - 'null'
      - string
    doc: Query string
    inputBinding:
      position: 102
      prefix: --query
  - id: query_path
    type:
      - 'null'
      - File
    doc: Path to query file
    inputBinding:
      position: 102
      prefix: --query-path
  - id: skip_history
    type:
      - 'null'
      - boolean
    doc: Skip history
    inputBinding:
      position: 102
      prefix: --skip-history
  - id: url
    type:
      - 'null'
      - string
    doc: URL to query
    inputBinding:
      position: 102
      prefix: --url
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eider:0.3--hdfd78af_0
stdout: eider_generate-completion.out
