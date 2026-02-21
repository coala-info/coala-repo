cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmerfinder
label: kmerfinder
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime environment.\n\nTool homepage:
  https://bitbucket.org/genomicepidemiology/kmerfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerfinder:3.0.2--hdfd78af_0
stdout: kmerfinder.out
