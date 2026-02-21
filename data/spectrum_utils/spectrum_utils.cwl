cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectrum_utils
label: spectrum_utils
doc: "The provided text does not contain help information or usage instructions for
  spectrum_utils; it is a log of a failed container build process.\n\nTool homepage:
  https://github.com/bittremieux/spectrum_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spectrum_utils:0.5.0--pyhdfd78af_0
stdout: spectrum_utils.out
