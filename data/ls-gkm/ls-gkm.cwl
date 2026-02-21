cwlVersion: v1.2
class: CommandLineTool
baseCommand: ls-gkm
label: ls-gkm
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/Dongwon-Lee/lsgkm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ls-gkm:0.1.1--h9948957_0
stdout: ls-gkm.out
