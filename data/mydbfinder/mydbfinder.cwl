cwlVersion: v1.2
class: CommandLineTool
baseCommand: mydbfinder
label: mydbfinder
doc: "A tool for finding or managing databases (Note: The provided help text contains
  only container execution error logs and no usage information).\n\nTool homepage:
  https://bitbucket.org/genomicepidemiology/mydbfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mydbfinder:1.0.5--hdfd78af_0
stdout: mydbfinder.out
