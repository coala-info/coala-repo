cwlVersion: v1.2
class: CommandLineTool
baseCommand: nmrml2isa
label: nmrml2isa
doc: "A tool for converting nmrML files to ISA-Tab format. (Note: The provided help
  text contains only system error messages and no argument definitions.)\n\nTool homepage:
  http://github.com/ISA-tools/nmrml2isa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nmrml2isa:0.3.3--pyhdfd78af_0
stdout: nmrml2isa.out
