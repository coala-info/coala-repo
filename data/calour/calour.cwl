cwlVersion: v1.2
class: CommandLineTool
baseCommand: calour
label: calour
doc: "Calour: a software package for interactive microbiome data analysis. (Note:
  The provided help text contains only container build error logs and no usage information;
  arguments could not be extracted from the input.)\n\nTool homepage: https://biocore.github.io/calour/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calour:2020.8.6--pyhdfd78af_0
stdout: calour.out
