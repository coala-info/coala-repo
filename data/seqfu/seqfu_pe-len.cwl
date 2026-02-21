cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - pe-len
label: seqfu_pe-len
doc: "The provided text is an error log indicating a failure to build or run the SeqFu
  container due to insufficient disk space, and does not contain the help documentation
  for the tool.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_pe-len.out
