cwlVersion: v1.2
class: CommandLineTool
baseCommand: jcast
label: jcast
doc: "Junction-centric Alternative Splicing Tool (Note: The provided text contains
  system error logs and does not list command-line arguments).\n\nTool homepage: https://github.com/ed-lau/jcast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jcast:0.3.5--pyhdfd78af_0
stdout: jcast.out
