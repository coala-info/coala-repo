cwlVersion: v1.2
class: CommandLineTool
baseCommand: minibusco
label: minibusco_compleasm
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding container image building
  (no space left on device).\n\nTool homepage: https://github.com/huangnengCSU/minibusco"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minibusco:0.2.1--pyh7cba7a3_0
stdout: minibusco_compleasm.out
