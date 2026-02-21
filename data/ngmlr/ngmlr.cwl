cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngmlr
label: ngmlr
doc: "The provided text does not contain help information for ngmlr; it contains error
  messages related to a container runtime (Apptainer/Singularity) failing to pull
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/philres/ngmlr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngmlr:0.2.7--h077b44d_10
stdout: ngmlr.out
