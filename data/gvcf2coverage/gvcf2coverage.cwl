cwlVersion: v1.2
class: CommandLineTool
baseCommand: gvcf2coverage
label: gvcf2coverage
doc: "A tool to convert gVCF files to coverage information. (Note: The provided help
  text contains only container runtime error messages and does not list specific arguments
  or usage instructions.)\n\nTool homepage: https://github.com/varda/varda2_preprocessing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gvcf2coverage:0.1--h7b50bb2_11
stdout: gvcf2coverage.out
