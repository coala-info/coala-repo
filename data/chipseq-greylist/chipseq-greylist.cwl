cwlVersion: v1.2
class: CommandLineTool
baseCommand: chipseq-greylist
label: chipseq-greylist
doc: "A tool for identifying greylist regions in ChIP-seq data. Note: The provided
  help text appears to be a container execution error log rather than command usage
  documentation.\n\nTool homepage: https://github.com/roryk/chipseq-greylist"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chipseq-greylist:1.0.2--pyh145b6a8_1
stdout: chipseq-greylist.out
