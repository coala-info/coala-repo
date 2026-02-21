cwlVersion: v1.2
class: CommandLineTool
baseCommand: fast2q
label: fast2q_2fast2q
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log regarding a container build failure (no space left
  on device).\n\nTool homepage: https://github.com/afombravo/2FAST2Q"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast2q:2.8.1--pyh7e72e81_0
stdout: fast2q_2fast2q.out
