cwlVersion: v1.2
class: CommandLineTool
baseCommand: codoff
label: codoff
doc: "A tool for detecting off-target effects in coding regions. (Note: The provided
  text contains system error messages and does not include usage instructions or argument
  definitions).\n\nTool homepage: https://github.com/Kalan-Lab/codoff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codoff:1.2.3--pyhdfd78af_0
stdout: codoff.out
