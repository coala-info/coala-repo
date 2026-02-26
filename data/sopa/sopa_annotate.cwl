cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sopa
  - annotate
label: sopa_annotate
doc: "Annotate spatial data\n\nTool homepage: https://gustaveroussy.github.io/sopa"
inputs:
  - id: command
    type: string
    doc: The subcommand to run
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
stdout: sopa_annotate.out
