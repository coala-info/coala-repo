cwlVersion: v1.2
class: CommandLineTool
baseCommand: dinf
label: dinf
doc: "The provided text does not contain help information for the tool 'dinf'. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/RacimoLab/dinf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dinf:0.5.0--pyhdfd78af_0
stdout: dinf.out
