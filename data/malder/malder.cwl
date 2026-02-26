cwlVersion: v1.2
class: CommandLineTool
baseCommand: malder
label: malder
doc: "ALDER computes weighted LD decay curves, performs curve-fitting to infer admixture
  dates, and uses the results to test for admixture.\n\nTool homepage: https://github.com/joepickrell/malder"
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
    dockerPull: quay.io/biocontainers/malder:1.0.1e83d4e--he3c7034_8
stdout: malder.out
