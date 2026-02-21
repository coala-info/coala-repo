cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgt-hint
label: rgt_rgt-hint
doc: "Regulatory Genomics Toolbox (RGT) - HMM-based Identification of TF Footprints.
  (Note: The provided text contains container build logs rather than tool help text;
  no arguments could be extracted).\n\nTool homepage: http://www.regulatory-genomics.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgt:1.0.2--py37he4a0461_0
stdout: rgt_rgt-hint.out
