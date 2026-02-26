cwlVersion: v1.2
class: CommandLineTool
baseCommand: djinn sam
label: djinn_sam
doc: "SAM/BAM file conversions and modifications\n\nTool homepage: https://github.com/pdimens/djinn"
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
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
stdout: djinn_sam.out
