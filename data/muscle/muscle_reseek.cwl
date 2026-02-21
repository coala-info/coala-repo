cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - muscle
  - reseek
label: muscle_reseek
doc: "The provided text does not contain help documentation; it contains system error
  messages related to a container runtime (Apptainer/Singularity) failing to build
  an image due to insufficient disk space.\n\nTool homepage: https://github.com/rcedgar/muscle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muscle:5.3--h9948957_3
stdout: muscle_reseek.out
