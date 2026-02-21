cwlVersion: v1.2
class: CommandLineTool
baseCommand: lemon
label: lemon
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log regarding a container execution failure (no space
  left on device).\n\nTool homepage: https://github.com/nayafia/lemonade-stand"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lemon:1.3.1--0
stdout: lemon.out
