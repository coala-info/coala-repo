cwlVersion: v1.2
class: CommandLineTool
baseCommand: linkedsv
label: linkedsv
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a container runtime (Singularity/Apptainer)
  failing to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/WGLab/LinkedSV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linkedsv:0.1.0--h077b44d_0
stdout: linkedsv.out
