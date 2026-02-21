cwlVersion: v1.2
class: CommandLineTool
baseCommand: mvicuna
label: mvicuna
doc: "The provided text does not contain help information for mvicuna; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/broadinstitute/mvicuna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mvicuna:1.0--h9948957_11
stdout: mvicuna.out
