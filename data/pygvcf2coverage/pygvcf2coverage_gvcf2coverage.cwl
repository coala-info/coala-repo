cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pygvcf2coverage
  - gvcf2coverage
label: pygvcf2coverage_gvcf2coverage
doc: "A tool to convert gVCF files to coverage. (Note: The provided help text contains
  only system logs and error messages; no specific command-line arguments could be
  extracted from the input.)\n\nTool homepage: https://github.com/varda/varda2_preprocessing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygvcf2coverage:0.2--py_0
stdout: pygvcf2coverage_gvcf2coverage.out
