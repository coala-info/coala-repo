cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastan
label: fastan
doc: "The provided text does not contain help information for the tool 'fastan'. It
  contains error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/thegenemyers/FASTAN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastan:0.5--h577a1d6_0
stdout: fastan.out
