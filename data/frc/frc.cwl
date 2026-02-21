cwlVersion: v1.2
class: CommandLineTool
baseCommand: frc
label: frc
doc: "The provided text does not contain help information for the tool 'frc'. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull an image due to lack of disk space.\n\nTool homepage: https://github.com/lucasjinreal/keras_frcnn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frc:5b3f53e--boost1.64_0
stdout: frc.out
