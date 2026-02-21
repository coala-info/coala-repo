cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hapbin
  - ehhbin
label: hapbin_ehhbin
doc: "The provided text is an error log indicating a failure to build or run the container
  image and does not contain help documentation for the tool.\n\nTool homepage: https://github.com/evotools/hapbin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapbin:1.3.0--h503566f_6
stdout: hapbin_ehhbin.out
