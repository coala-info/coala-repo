cwlVersion: v1.2
class: CommandLineTool
baseCommand: suppa
label: suppa
doc: "The provided text does not contain help information or usage instructions for
  the tool 'suppa'. It appears to be a log of a failed container build or fetch operation.\n
  \nTool homepage: https://github.com/comprna/SUPPA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suppa:2.4--pyhdfd78af_0
stdout: suppa.out
