cwlVersion: v1.2
class: CommandLineTool
baseCommand: karect
label: karect
doc: "The provided text does not contain help information for the tool 'karect'. It
  contains system error messages related to a container runtime (Apptainer/Singularity)
  failing to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/aminallam/karect"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/karect:1.0--h9948957_9
stdout: karect.out
