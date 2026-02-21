cwlVersion: v1.2
class: CommandLineTool
baseCommand: stemcnv-check
label: stemcnv-check
doc: "A tool for detecting and checking copy number variations (CNVs) in stem cell
  lines.\n\nTool homepage: https://github.com/bihealth/StemCNV-check"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stemcnv-check:1.0.0--pyhdfd78af_0
stdout: stemcnv-check.out
