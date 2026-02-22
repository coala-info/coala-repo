cwlVersion: v1.2
class: CommandLineTool
baseCommand: comebin
label: comebin
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error messages related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/ziyewang/COMEBin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comebin:1.0.4--hdfd78af_1
stdout: comebin.out
