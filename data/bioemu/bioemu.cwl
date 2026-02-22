cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioemu
label: bioemu
doc: "A tool for biological emulation (Note: The provided text contains system error
  messages regarding container execution and does not include specific help documentation
  or argument details).\n\nTool homepage: https://github.com/microsoft/bioemu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioemu:1.2.0--pyhdfd78af_0
stdout: bioemu.out
