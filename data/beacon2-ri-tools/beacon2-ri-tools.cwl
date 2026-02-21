cwlVersion: v1.2
class: CommandLineTool
baseCommand: beacon2-ri-tools
label: beacon2-ri-tools
doc: "Beacon v2 Reference Implementation Tools (Note: The provided text is a container
  build error log and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/EGA-archive/beacon2-ri-tools/tree/main"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beacon2-ri-tools:2.0.5--py310hdfd78af_0
stdout: beacon2-ri-tools.out
