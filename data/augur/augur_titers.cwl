cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur_titers
label: augur_titers
doc: "Annotate a tree with actual and inferred titer measurements.\n\nTool homepage:
  https://github.com/nextstrain/augur"
inputs:
  - id: subcommand
    type: string
    doc: 'Subcommand to run: tree or sub'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
stdout: augur_titers.out
