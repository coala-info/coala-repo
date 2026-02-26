cwlVersion: v1.2
class: CommandLineTool
baseCommand: dict-utils
label: mgkit_dict-utils
doc: "Main function for dictionary utility commands\n\nTool homepage: https://github.com/frubino/mgkit"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (reverse, split)
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
  - id: cite
    type:
      - 'null'
      - boolean
    doc: Show citation information
    inputBinding:
      position: 103
      prefix: --cite
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
stdout: mgkit_dict-utils.out
