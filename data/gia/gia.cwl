cwlVersion: v1.2
class: CommandLineTool
baseCommand: gia
label: gia
doc: "A tool for genomic interval arithmetic and processing (Note: The provided help
  text contains only container runtime error messages and no usage information).\n
  \nTool homepage: https://github.com/noamteyssier/gia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gia:0.2.23--h588a25a_0
stdout: gia.out
