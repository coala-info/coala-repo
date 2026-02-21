cwlVersion: v1.2
class: CommandLineTool
baseCommand: lsabgc
label: lsabgc
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  build an image due to insufficient disk space.\n\nTool homepage: https://github.com/Kalan-Lab/lsaBGC-Pan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
stdout: lsabgc.out
