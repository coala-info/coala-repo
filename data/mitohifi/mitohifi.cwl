cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitohifi
label: mitohifi
doc: "MitoHiFi is a pipeline for mitochondrial genome assembly from PacBio HiFi reads.\n
  \nTool homepage: https://github.com/marcelauliano/MitoHiFi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mitohifi:2.2_cv1
stdout: mitohifi.out
