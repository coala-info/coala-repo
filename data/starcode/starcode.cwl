cwlVersion: v1.2
class: CommandLineTool
baseCommand: starcode
label: starcode
doc: "The provided text does not contain help information for starcode; it is an error
  log from a container runtime (Apptainer/Singularity) failing to fetch the starcode
  image.\n\nTool homepage: https://github.com/gui11aume/starcode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/starcode:1.4--h7b50bb2_7
stdout: starcode.out
