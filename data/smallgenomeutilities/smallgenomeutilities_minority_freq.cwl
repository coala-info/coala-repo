cwlVersion: v1.2
class: CommandLineTool
baseCommand: smallgenomeutilities_minority_freq
label: smallgenomeutilities_minority_freq
doc: "A utility from the smallgenomeutilities package. (Note: The provided text contains
  container build logs rather than help documentation, so no arguments could be extracted.)\n
  \nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
stdout: smallgenomeutilities_minority_freq.out
