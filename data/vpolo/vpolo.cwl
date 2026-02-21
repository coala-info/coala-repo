cwlVersion: v1.2
class: CommandLineTool
baseCommand: vpolo
label: vpolo
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container build process (Apptainer/Singularity)
  failing to fetch the vpolo image.\n\nTool homepage: https://github.com/k3yavi/vpolo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpolo:0.3.0--pyh864c0ab_0
stdout: vpolo.out
