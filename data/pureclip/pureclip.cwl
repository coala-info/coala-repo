cwlVersion: v1.2
class: CommandLineTool
baseCommand: pureclip
label: pureclip
doc: "PureCLIP: a tool for identifying protein-RNA interaction sites from CLIP-seq
  data. (Note: The provided help text contains only system logs and error messages;
  no arguments could be extracted from the input.)\n\nTool homepage: https://github.com/skrakau/PureCLIP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pureclip:1.3.1--r44h9ee0642_2
stdout: pureclip.out
