cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfastats
label: gfastats
doc: "The provided text does not contain help information or a description of the
  tool. It contains a fatal error message from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space.\n\nTool homepage:
  https://github.com/vgl-hub/gfastats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfastats:1.3.11--h077b44d_0
stdout: gfastats.out
