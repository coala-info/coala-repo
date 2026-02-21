cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp
label: vsnp
doc: "The provided text does not contain help information or usage instructions for
  the 'vsnp' tool. It contains log messages and a fatal error related to building
  a container image.\n\nTool homepage: https://github.com/USDA-VS/vSNP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
stdout: vsnp.out
