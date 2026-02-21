cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometester4
label: genometester4
doc: "The provided text does not contain help information for genometester4; it is
  an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometester4:4.0--h7b50bb2_7
stdout: genometester4.out
