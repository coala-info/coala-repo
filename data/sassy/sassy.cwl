cwlVersion: v1.2
class: CommandLineTool
baseCommand: sassy
label: sassy
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sassy'. It appears to be a log of a failed container build/pull process.\n
  \nTool homepage: https://github.com/ragnargrootkoerkamp/sassy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sassy:0.1.8--h4349ce8_0
stdout: sassy.out
