cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamaligncleaner
label: bamaligncleaner
doc: "A tool for cleaning BAM alignments (Note: The provided help text contains only
  system error logs and no usage information).\n\nTool homepage: https://github.com/maxibor/bamAlignCleaner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamaligncleaner:0.3--pyhdfd78af_0
stdout: bamaligncleaner.out
