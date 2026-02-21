cwlVersion: v1.2
class: CommandLineTool
baseCommand: SemiBin2
label: semibin_SemiBin2
doc: "SemiBin2 is a tool for metagenomic binning using self-supervised deep learning.
  (Note: The provided help text contains only system error logs regarding a failed
  container build and does not list command-line arguments.)\n\nTool homepage: https://github.com/BigDataBiology/SemiBin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/semibin:2.2.1--pyhdfd78af_0
stdout: semibin_SemiBin2.out
