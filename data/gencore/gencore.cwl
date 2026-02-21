cwlVersion: v1.2
class: CommandLineTool
baseCommand: gencore
label: gencore
doc: "The provided text does not contain help information for the tool 'gencore'.
  It contains error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/OpenGene/gencore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gencore:0.17.2--he5ce664_4
stdout: gencore.out
