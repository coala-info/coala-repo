cwlVersion: v1.2
class: CommandLineTool
baseCommand: mm2plus
label: mm2plus
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the mm2plus
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/at-cg/mm2-plus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mm2plus:1.2--h9ee0642_0
stdout: mm2plus.out
