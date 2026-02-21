cwlVersion: v1.2
class: CommandLineTool
baseCommand: ganon
label: ganon
doc: "The provided text does not contain help information for the tool 'ganon'. It
  appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the container due to insufficient disk space.\n\n
  Tool homepage: https://github.com/pirovc/ganon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ganon:2.1.1--py39h69c296c_0
stdout: ganon.out
