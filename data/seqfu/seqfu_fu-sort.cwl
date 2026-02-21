cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - sort
label: seqfu_fu-sort
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding a failed container build (no space left on device).
  Based on the tool name hint, this tool is part of the SeqFu suite used for sorting
  biological sequences.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_fu-sort.out
