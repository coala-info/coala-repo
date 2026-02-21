cwlVersion: v1.2
class: CommandLineTool
baseCommand: fstic
label: fstic
doc: "The provided text does not contain help information for the tool 'fstic'. It
  contains error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/PathoGenOmics-Lab/fstic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fstic:1.0.0--h4349ce8_0
stdout: fstic.out
