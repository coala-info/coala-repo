cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnvnator
label: cnvnator
doc: "CNVnator is a tool for CNV discovery and genotyping from depth-of-coverage.
  (Note: The provided text contains container runtime error messages rather than command-line
  help documentation.)\n\nTool homepage: https://github.com/abyzovlab/CNVnator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvnator:0.4.1--py312h99c8fb2_11
stdout: cnvnator.out
