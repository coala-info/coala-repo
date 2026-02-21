cwlVersion: v1.2
class: CommandLineTool
baseCommand: gffutils
label: gffutils
doc: "The provided text does not contain help information for gffutils. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  due to insufficient disk space.\n\nTool homepage: https://github.com/daler/gffutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gffutils:0.13--pyh7cba7a3_0
stdout: gffutils.out
