cwlVersion: v1.2
class: CommandLineTool
baseCommand: casmoothing
label: casmoothing
doc: "The provided text does not contain help documentation for the tool. It contains
  system error messages regarding a failed container build due to insufficient disk
  space.\n\nTool homepage: https://github.com/tfmoraes/python-casmoothing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/casmoothing:v0.2-1b1-deb-py2_cv1
stdout: casmoothing.out
