cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmer_counter
label: genometester4_gmer_counter
doc: "The provided text does not contain help documentation for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometester4:4.0--h7b50bb2_7
stdout: genometester4_gmer_counter.out
