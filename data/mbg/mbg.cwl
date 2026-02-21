cwlVersion: v1.2
class: CommandLineTool
baseCommand: mbg
label: mbg
doc: "The provided text does not contain help information for the tool 'mbg'. It contains
  error messages from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container due to lack of disk space.\n\nTool homepage: https://github.com/maickrau/MBG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mbg:1.0.17--h06902ac_0
stdout: mbg.out
