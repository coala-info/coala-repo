cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmblast
label: rmblast
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the rmblast image.\n\nTool homepage: https://www.repeatmasker.org/rmblast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmblast:2.14.1--hdb21ba3_2
stdout: rmblast.out
