cwlVersion: v1.2
class: CommandLineTool
baseCommand: fstruct
label: heasoft_fstruct
doc: "The provided help text contains only system error messages (FATAL: Unable to
  handle docker uri, no space left on device) and does not contain the actual help
  documentation for the tool. As a result, arguments and tool-specific descriptions
  cannot be extracted.\n\nTool homepage: https://heasarc.gsfc.nasa.gov/lheasoft/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/heasoft:6.35.2--hedafe93_1
stdout: heasoft_fstruct.out
