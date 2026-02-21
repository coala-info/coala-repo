cwlVersion: v1.2
class: CommandLineTool
baseCommand: ivar
label: ivar
doc: "The provided text does not contain help information for the tool 'ivar'. It
  appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failing to pull the ivar image due to insufficient disk space.\n\nTool homepage:
  https://andersen-lab.github.io/ivar/html/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ivar:1.4.4--h077b44d_0
stdout: ivar.out
