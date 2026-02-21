cwlVersion: v1.2
class: CommandLineTool
baseCommand: canvas_FlagUniqueKmers
label: canvas_FlagUniqueKmers
doc: "A tool for flagging unique kmers (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/Illumina/canvas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/canvas:1.35.1.1316--0
stdout: canvas_FlagUniqueKmers.out
