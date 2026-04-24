cwlVersion: v1.2
class: CommandLineTool
baseCommand: cleanifier
label: cleanifier
doc: "fast lightweight tool to remove all reads of a species\n\nTool homepage: https://gitlab.com/rahmannlab/cleanifier"
inputs:
  - id: subcommand
    type: string
    doc: 'Available subcommands: index, filter, info, download, load, remove'
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: output debugging information (repeat for more)
    inputBinding:
      position: 102
      prefix: --debug
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0
stdout: cleanifier.out
