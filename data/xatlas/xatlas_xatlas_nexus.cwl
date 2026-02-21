cwlVersion: v1.2
class: CommandLineTool
baseCommand: xatlas
label: xatlas_xatlas_nexus
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the xatlas image.\n\nTool homepage: https://github.com/jfarek/xatlas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xatlas:0.3--h9948957_5
stdout: xatlas_xatlas_nexus.out
