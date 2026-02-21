cwlVersion: v1.2
class: CommandLineTool
baseCommand: sniffles
label: sniffles
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build/fetch process for the Sniffles tool
  (version 2.7.2).\n\nTool homepage: https://github.com/fritzsedlazeck/Sniffles"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sniffles:2.7.2--pyhdfd78af_0
stdout: sniffles.out
