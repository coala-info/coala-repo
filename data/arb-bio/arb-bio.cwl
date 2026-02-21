cwlVersion: v1.2
class: CommandLineTool
baseCommand: arb-bio
label: arb-bio
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log of a failed execution or build process.\n\nTool homepage:
  http://www.arb-home.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arb-bio:6.0.6--0
stdout: arb-bio.out
