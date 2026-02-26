cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler cload
label: cooler_cload
doc: "Create a cooler from genomic pairs and bins.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: command
    type: string
    doc: Choose a subcommand based on the format of the input contact list.
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the chosen command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
stdout: cooler_cload.out
