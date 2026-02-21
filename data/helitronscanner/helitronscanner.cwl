cwlVersion: v1.2
class: CommandLineTool
baseCommand: helitronscanner
label: helitronscanner
doc: "A tool for identifying Helitron transposable elements (Note: The provided help
  text contains only container execution errors and no usage information).\n\nTool
  homepage: https://sourceforge.net/projects/helitronscanner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/helitronscanner:1.0--hdfd78af_0
stdout: helitronscanner.out
