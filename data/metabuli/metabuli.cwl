cwlVersion: v1.2
class: CommandLineTool
baseCommand: metabuli
label: metabuli
doc: "Metabuli is a tool for metagenomic classification, however, the provided text
  contains only system error messages and no help documentation to parse.\n\nTool
  homepage: https://github.com/steineggerlab/Metabuli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabuli:1.1.0--pl5321hd6d6fdc_0
stdout: metabuli.out
