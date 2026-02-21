cwlVersion: v1.2
class: CommandLineTool
baseCommand: msms
label: msms
doc: "The provided text contains error messages related to a container runtime (Apptainer/Singularity)
  failure and does not include the help documentation for the msms tool. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/MotorolaMobilityLLC/kernel-msm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msms:2.6.1--1
stdout: msms.out
