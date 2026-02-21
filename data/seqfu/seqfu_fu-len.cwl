cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - fu-len
label: seqfu_fu-len
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failed container build due to insufficient disk space.\n\nTool
  homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_fu-len.out
