cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - interleafq
label: seqfu_interleafq
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log indicating a failed container build due to lack of disk
  space.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_interleafq.out
