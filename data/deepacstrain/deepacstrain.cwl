cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepacstrain
label: deepacstrain
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  building (no space left on device).\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacstrain:0.2.1--py_0
stdout: deepacstrain.out
