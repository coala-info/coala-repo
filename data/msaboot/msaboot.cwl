cwlVersion: v1.2
class: CommandLineTool
baseCommand: msaboot
label: msaboot
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/phac-nml/msaboot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msaboot:0.1.2--py_1
stdout: msaboot.out
