cwlVersion: v1.2
class: CommandLineTool
baseCommand: smashpp
label: smashpp
doc: "The provided text does not contain help information for smashpp. It appears
  to be a container execution error log from Apptainer/Singularity indicating a failure
  to fetch or build the image.\n\nTool homepage: https://github.com/smortezah/smashpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smashpp:23.09--h9948957_1
stdout: smashpp.out
