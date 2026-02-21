cwlVersion: v1.2
class: CommandLineTool
baseCommand: isaac4
label: isaac4
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container runtime (Apptainer/Singularity)
  failing due to insufficient disk space.\n\nTool homepage: https://github.com/Illumina/Isaac4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isaac4:04.18.11.09--h07bff40_0
stdout: isaac4.out
