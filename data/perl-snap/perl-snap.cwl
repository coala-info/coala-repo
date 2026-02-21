cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-snap
label: perl-snap
doc: "The provided text does not contain help information or a description for the
  tool; it is a log of a failed execution indicating the executable was not found.\n
  \nTool homepage: https://www.hiv.lanl.gov/content/sequence/SNAP/SNAP.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-snap:2.1.1--pl526_0
stdout: perl-snap.out
