cwlVersion: v1.2
class: CommandLineTool
baseCommand: spydrpick
label: spydrpick
doc: "The provided text does not contain help information or usage instructions for
  spydrpick; it contains container runtime error logs.\n\nTool homepage: https://github.com/santeripuranen/SpydrPick"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spydrpick:1.2.0--h78a066a_0
stdout: spydrpick.out
