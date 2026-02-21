cwlVersion: v1.2
class: CommandLineTool
baseCommand: tiara
label: tiara
doc: "The provided text does not contain help information for the tool 'tiara'. It
  appears to be a log of a failed container build/fetch process.\n\nTool homepage:
  https://github.com/savetz/tiara"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiara:1.0.3
stdout: tiara.out
