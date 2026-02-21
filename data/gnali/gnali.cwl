cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnali
label: gnali
doc: "GNALI (Gene Name Likelihood) - A tool for identifying potentially loss-of-function
  variants.\n\nTool homepage: https://github.com/phac-nml/gnali"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnali:1.1.0--pyhdfd78af_0
stdout: gnali.out
