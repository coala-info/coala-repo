cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidid
label: plasmidid
doc: "PlasmidID is a tool for plasmid identification (Note: The provided text contains
  system error logs rather than help documentation, so specific arguments could not
  be extracted).\n\nTool homepage: https://github.com/BU-ISCIII/plasmidID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidid:1.6.5--hdfd78af_0
stdout: plasmidid.out
