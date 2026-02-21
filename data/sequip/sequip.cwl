cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequip
label: sequip
doc: "A tool for sequence processing (Note: The provided text is an error log from
  a container build failure and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/nawrockie/sequip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequip:0.11--hdfd78af_0
stdout: sequip.out
