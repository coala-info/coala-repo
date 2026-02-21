cwlVersion: v1.2
class: CommandLineTool
baseCommand: alder
label: alder
doc: "ALDER computes weighted LD decay curves, performs curve-fitting to infer admixture
  dates, and uses the results to test for admixture.\n\nTool homepage: http://cb.csail.mit.edu/cb/alder/"
inputs:
  - id: parameter_file
    type: File
    doc: parameter file
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alder:1.03--h13c21de_7
stdout: alder.out
