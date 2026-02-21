cwlVersion: v1.2
class: CommandLineTool
baseCommand: souporcell
label: souporcell
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/wheaton5/souporcell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/souporcell:2.5--hc1c3326_0
stdout: souporcell.out
