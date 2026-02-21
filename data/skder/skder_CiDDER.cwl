cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - skder
  - CiDDER
label: skder_CiDDER
doc: "The provided text is a container runtime error log and does not contain help
  information or argument definitions for the tool.\n\nTool homepage: https://github.com/raufs/skDER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skder:1.3.4--py310h184ae93_0
stdout: skder_CiDDER.out
