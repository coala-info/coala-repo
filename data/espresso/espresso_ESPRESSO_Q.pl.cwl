cwlVersion: v1.2
class: CommandLineTool
baseCommand: espresso_ESPRESSO_Q.pl
label: espresso_ESPRESSO_Q.pl
doc: "ESPRESSO (Error-tolerant Shorthand Pipeline for Splicing Isoform RNA-seq) quantification
  module. Note: The provided help text contains only system error logs and no usage
  information.\n\nTool homepage: https://github.com/Xinglab/espresso"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/espresso:1.6.0--pl5321h5ca1c30_1
stdout: espresso_ESPRESSO_Q.pl.out
