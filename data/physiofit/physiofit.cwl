cwlVersion: v1.2
class: CommandLineTool
baseCommand: physiofit
label: physiofit
doc: "The provided text contains system error messages related to container image
  acquisition (no space left on device) and does not contain help documentation for
  the tool. As a result, no arguments or descriptions could be extracted.\n\nTool
  homepage: https://github.com/MetaSys-LISBP/PhysioFit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physiofit:3.4.0--pyhdfd78af_0
stdout: physiofit.out
