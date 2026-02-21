cwlVersion: v1.2
class: CommandLineTool
baseCommand: arb-bio-devel
label: arb-bio-devel
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log of a failed execution or build process where the executable
  was not found.\n\nTool homepage: http://www.arb-home.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arb-bio-devel:6.0.6--h6bb024c_8
stdout: arb-bio-devel.out
