cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgt-motifanalysis
label: rgt_rgt-motifanalysis
doc: "A tool from the Regulatory Genomics Toolbox (RGT) for performing motif analysis.
  Note: The provided help text contains only container runtime error messages and
  does not list specific arguments.\n\nTool homepage: http://www.regulatory-genomics.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgt:1.0.2--py37he4a0461_0
stdout: rgt_rgt-motifanalysis.out
