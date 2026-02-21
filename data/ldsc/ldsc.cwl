cwlVersion: v1.2
class: CommandLineTool
baseCommand: ldsc
label: ldsc
doc: "LD Score Regression (LDSC) is a tool for estimating heritability and genetic
  correlation from GWAS summary statistics. (Note: The provided text is a system error
  message and does not contain usage instructions or argument definitions).\n\nTool
  homepage: https://github.com/bulik/ldsc/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ldsc:1.0.1--py_0
stdout: ldsc.out
