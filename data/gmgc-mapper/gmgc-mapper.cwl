cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmgc-mapper
label: gmgc-mapper
doc: "The provided text does not contain help documentation or usage instructions.
  It contains system error logs related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/BigDataBiology/GMGC-mapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmgc-mapper:0.2.0--pyh864c0ab_1
stdout: gmgc-mapper.out
