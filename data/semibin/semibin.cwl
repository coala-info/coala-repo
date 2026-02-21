cwlVersion: v1.2
class: CommandLineTool
baseCommand: semibin
label: semibin
doc: "Semi-supervised community-level metagenomic binning\n\nTool homepage: https://github.com/BigDataBiology/SemiBin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/semibin:2.2.1--pyhdfd78af_0
stdout: semibin.out
