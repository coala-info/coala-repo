cwlVersion: v1.2
class: CommandLineTool
baseCommand: fpocketr
label: fpocketr
doc: "The provided text does not contain help information for fpocketr; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  due to insufficient disk space.\n\nTool homepage: https://github.com/Weeks-UNC/fpocketR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fpocketr:1.3.4--pyhdfd78af_0
stdout: fpocketr.out
