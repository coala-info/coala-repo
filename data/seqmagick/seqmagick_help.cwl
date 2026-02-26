cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqmagick
  - help
label: seqmagick_help
doc: "Show help for seqmagick actions.\n\nTool homepage: http://github.com/fhcrc/seqmagick"
inputs:
  - id: action
    type: string
    doc: The action to show help for.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
stdout: seqmagick_help.out
