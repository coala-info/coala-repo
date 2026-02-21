cwlVersion: v1.2
class: CommandLineTool
baseCommand: k8
label: fermikit_k8
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image creation (no space left on device).\n\nTool homepage: https://github.com/lh3/fermikit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_k8.out
