cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnabridge-align
label: rnabridge-align
doc: "The provided text does not contain help information for rnabridge-align; it
  contains error logs from a container runtime (Apptainer/Singularity) failing to
  fetch the tool's image.\n\nTool homepage: https://github.com/Shao-Group/rnabridge-align"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnabridge-align:1.0.1--h5ca1c30_9
stdout: rnabridge-align.out
