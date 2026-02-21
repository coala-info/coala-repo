cwlVersion: v1.2
class: CommandLineTool
baseCommand: thesias
label: thesias
doc: "THESIAS (Testing Haplotype Effects In Association Studies) is a program designed
  to perform haplotype-based association analysis in unrelated individuals. (Note:
  The provided text is a container execution log and does not contain help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/daissi/thesias"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thesias:3.1.1--h7b50bb2_6
stdout: thesias.out
