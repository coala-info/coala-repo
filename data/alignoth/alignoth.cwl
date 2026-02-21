cwlVersion: v1.2
class: CommandLineTool
baseCommand: alignoth
label: alignoth
doc: "The provided text does not contain help information or a description of the
  tool; it is a container build error log indicating a 'no space left on device' failure
  during image extraction.\n\nTool homepage: https://github.com/koesterlab/alignoth"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alignoth:1.4.4--h1520f10_0
stdout: alignoth.out
