cwlVersion: v1.2
class: CommandLineTool
baseCommand: samblaster
label: samblaster
doc: "The provided text does not contain help information for samblaster; it is a
  container build error log. No arguments could be extracted.\n\nTool homepage: https://github.com/GregoryFaust/samblaster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samblaster:0.1.26--h9948957_7
stdout: samblaster.out
