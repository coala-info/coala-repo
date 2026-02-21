cwlVersion: v1.2
class: CommandLineTool
baseCommand: netreg
label: netreg
doc: "The provided text does not contain help information or usage instructions for
  the tool 'netreg'. It contains error logs related to a container runtime (Apptainer/Singularity)
  failing to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/dirmeier/netReg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/netreg:1.8.0--h9fd3d4c_0
stdout: netreg.out
