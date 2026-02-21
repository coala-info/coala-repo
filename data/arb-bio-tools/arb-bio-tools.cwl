cwlVersion: v1.2
class: CommandLineTool
baseCommand: arb-bio-tools
label: arb-bio-tools
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it is an error log indicating that the executable was not
  found.\n\nTool homepage: http://www.arb-home.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arb-bio-tools:6.0.6--4
stdout: arb-bio-tools.out
