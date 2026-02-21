cwlVersion: v1.2
class: CommandLineTool
baseCommand: mzml2isa
label: mzml2isa
doc: "A tool for converting mzML files to ISA-Tab format. (Note: The provided help
  text contains only system error messages and no argument definitions.)\n\nTool homepage:
  https://github.com/ISA-tools/mzml2isa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mzml2isa:1.1.1--pyhdfd78af_0
stdout: mzml2isa.out
