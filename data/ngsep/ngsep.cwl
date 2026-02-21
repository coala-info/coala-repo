cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngsep
label: ngsep
doc: "Next Generation Sequencing Experience Platform (NGSEP). Note: The provided text
  contains system error messages regarding container execution and does not include
  usage instructions or argument definitions.\n\nTool homepage: https://github.com/NGSEP/NGSEPcore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsep:4.0.1--0
stdout: ngsep.out
