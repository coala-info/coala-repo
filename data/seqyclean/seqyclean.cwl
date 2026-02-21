cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqyclean
label: seqyclean
doc: "A tool for preprocessing Next Generation Sequencing (NGS) data. (Note: The provided
  text is an error log and does not contain usage information or argument definitions.)\n
  \nTool homepage: https://github.com/ibest/seqyclean"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqyclean:1.10.09--h5ca1c30_6
stdout: seqyclean.out
