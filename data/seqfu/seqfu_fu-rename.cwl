cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - fu-rename
label: seqfu_fu-rename
doc: "The provided text is an error log indicating a failure to build or run the container
  image (no space left on device) and does not contain the help text or usage information
  for the tool.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_fu-rename.out
