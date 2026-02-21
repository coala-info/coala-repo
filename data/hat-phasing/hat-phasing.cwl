cwlVersion: v1.2
class: CommandLineTool
baseCommand: hat-phasing
label: hat-phasing
doc: "A tool for haplotype phasing. (Note: The provided text is a system error log
  indicating a failure to pull the container image and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/AbeelLab/hat/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hat-phasing:0.1.8--pyh5e36f6f_0
stdout: hat-phasing.out
