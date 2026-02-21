cwlVersion: v1.2
class: CommandLineTool
baseCommand: merquryfk_HAPmaker
label: merquryfk_HAPmaker
doc: "The provided help text contains only system error messages related to a container
  runtime failure (no space left on device) and does not contain usage information
  or argument definitions for the tool.\n\nTool homepage: https://github.com/thegenemyers/MERQURY.FK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merquryfk:1.2--h71df26d_1
stdout: merquryfk_HAPmaker.out
