cwlVersion: v1.2
class: CommandLineTool
baseCommand: methplotlib
label: methplotlib
doc: "A tool for plotting modified nucleotides (methylation) from nanopore sequencing
  data.\n\nTool homepage: https://github.com/wdecoster/methplotlib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methplotlib:0.21.2--pyhdfd78af_0
stdout: methplotlib.out
