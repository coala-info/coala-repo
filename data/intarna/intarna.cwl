cwlVersion: v1.2
class: CommandLineTool
baseCommand: intarna
label: intarna
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain CLI help information or argument definitions for the tool 'intarna'.\n
  \nTool homepage: https://github.com/BackofenLab/IntaRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
stdout: intarna.out
