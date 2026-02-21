cwlVersion: v1.2
class: CommandLineTool
baseCommand: unanimity
label: unanimity
doc: "The provided text does not contain help information for the tool 'unanimity'.
  It contains log messages and a fatal error related to a container build process
  (Apptainer/Singularity).\n\nTool homepage: https://github.com/AGhaderi/MNE-Preprocessing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/unanimity:v3.3.0dfsg-2.1-deb_cv1
stdout: unanimity.out
