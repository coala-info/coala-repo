cwlVersion: v1.2
class: CommandLineTool
baseCommand: comparem2
label: comparem2
doc: "The provided text contains system error messages regarding disk space and container
  image conversion rather than the tool's help documentation. Consequently, no arguments
  or descriptions could be extracted.\n\nTool homepage: https://github.com/cmkobel/comparem2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparem2:2.16.2--hdfd78af_0
stdout: comparem2.out
