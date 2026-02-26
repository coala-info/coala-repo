cwlVersion: v1.2
class: CommandLineTool
baseCommand: snipe_ops
label: snipe_ops
doc: "Perform operations on SnipeSig signatures.\n\nTool homepage: https://github.com/snipe-bio/snipe"
inputs:
  - id: command
    type: string
    doc: The subcommand to run (common, guided-merge, intersect, subtract, sum, 
      union)
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
    dockerPull: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
stdout: snipe_ops.out
