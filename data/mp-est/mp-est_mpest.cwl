cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpest
label: mp-est_mpest
doc: "Maximum Pseudo-likelihood Estimation of Species Trees (MP-EST)\n\nTool homepage:
  https://github.com/lliu1871/mp-est"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mp-est:3.1.0--h7b50bb2_0
stdout: mp-est_mpest.out
