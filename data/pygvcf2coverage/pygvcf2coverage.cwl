cwlVersion: v1.2
class: CommandLineTool
baseCommand: pygvcf2coverage
label: pygvcf2coverage
doc: "A tool for converting gVCF files to coverage information.\n\nTool homepage:
  https://github.com/varda/varda2_preprocessing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygvcf2coverage:0.2--py_0
stdout: pygvcf2coverage.out
