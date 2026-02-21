cwlVersion: v1.2
class: CommandLineTool
baseCommand: sdeper_runDeconvolution
label: sdeper_runDeconvolution
doc: "Spatial DEconvolution by PrEcision Regression (SDEPER). Note: The provided help
  text contains only system error messages regarding container image extraction and
  does not list command-line arguments.\n\nTool homepage: https://az7jh2.github.io/SDePER/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sdeper:2.0.0--pyhdfd78af_0
stdout: sdeper_runDeconvolution.out
