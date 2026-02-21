cwlVersion: v1.2
class: CommandLineTool
baseCommand: hafez
label: hafez
doc: "A tool for haplotype-aware feature extraction and selection (Note: The provided
  text contains system error logs rather than help documentation, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/Chrisjrt/hafeZ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hafez:1.0.4--pyh7cba7a3_0
stdout: hafez.out
