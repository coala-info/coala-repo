cwlVersion: v1.2
class: CommandLineTool
baseCommand: mergevcf
label: mergevcf
doc: "A tool for merging VCF files. Note: The provided help text contains only container
  runtime error messages and does not list specific command-line arguments.\n\nTool
  homepage: https://github.com/ljdursi/mergevcf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mergevcf:1.0.1--py27_0
stdout: mergevcf.out
