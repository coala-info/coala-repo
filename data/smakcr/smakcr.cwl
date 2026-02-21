cwlVersion: v1.2
class: CommandLineTool
baseCommand: smakcr
label: smakcr
doc: "The provided text does not contain help information for the tool 'smakcr'. It
  appears to be a log of a failed container build or image fetch process.\n\nTool
  homepage: https://github.com/julibeg/smakcr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smakcr:0.1.0--h4349ce8_0
stdout: smakcr.out
