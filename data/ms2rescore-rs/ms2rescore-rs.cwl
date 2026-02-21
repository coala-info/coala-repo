cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms2rescore-rs
label: ms2rescore-rs
doc: "MS2Rescore: Sensitive peptide identification rescoring (Note: The provided text
  contains system error logs and does not include help documentation or argument definitions).\n
  \nTool homepage: https://github.com/compomics/ms2rescore-rs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms2rescore-rs:0.4.3--py311he252b13_0
stdout: ms2rescore-rs.out
