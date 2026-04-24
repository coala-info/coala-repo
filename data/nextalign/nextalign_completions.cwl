cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextalign
label: nextalign_completions
doc: "Align sequences to a reference or gene map.\n\nTool homepage: https://github.com/nextstrain/nextclade/tree/master/packages/nextalign_cli"
inputs:
  - id: completions
    type:
      - 'null'
      - boolean
    doc: Output shell completions for the specified shell
    inputBinding:
      position: 101
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Alias for --verbosity error
    inputBinding:
      position: 101
      prefix: --quiet
  - id: run
    type:
      - 'null'
      - boolean
    doc: Run the alignment
    inputBinding:
      position: 101
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Suppress all output
    inputBinding:
      position: 101
      prefix: --silent
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Alias for --verbosity info
    inputBinding:
      position: 101
      prefix: --verbose
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Set verbosity level
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextalign:2.14.0--h9ee0642_1
stdout: nextalign_completions.out
