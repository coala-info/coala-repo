cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnvpytor
label: cnvpytor
doc: "A tool for CNV analysis from depth-of-coverage and B-allele frequency (BAF)
  signals.\n\nTool homepage: https://github.com/abyzovlab/CNVpytor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvpytor:1.3.2--pyhdfd78af_0
stdout: cnvpytor.out
