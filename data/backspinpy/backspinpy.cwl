cwlVersion: v1.2
class: CommandLineTool
baseCommand: backspinpy
label: backspinpy
doc: "The provided text does not contain help information for the tool; it consists
  of system error messages related to a Singularity/Docker container execution failure
  (no space left on device).\n\nTool homepage: https://github.com/linnarsson-lab/BackSPIN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/backspinpy:0.2.1--pyh24bf2e0_1
stdout: backspinpy.out
