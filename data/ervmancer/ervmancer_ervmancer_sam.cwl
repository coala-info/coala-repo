cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ervmancer
  - sam
label: ervmancer_ervmancer_sam
doc: "The provided text does not contain help information or a description of the
  tool. It contains system log messages and a fatal error regarding container image
  building (no space left on device).\n\nTool homepage: https://github.com/AuslanderLab/ervmancer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ervmancer:0.0.4--pyhdfd78af_0
stdout: ervmancer_ervmancer_sam.out
