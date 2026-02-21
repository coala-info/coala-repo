cwlVersion: v1.2
class: CommandLineTool
baseCommand: gqt
label: gqt
doc: "The provided text does not contain help information for the tool 'gqt'. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/ryanlayer/gqt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gqt:1.1.3--h0263287_3
stdout: gqt.out
