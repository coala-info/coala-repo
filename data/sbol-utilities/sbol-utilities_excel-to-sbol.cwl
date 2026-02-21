cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - excel-to-sbol
label: sbol-utilities_excel-to-sbol
doc: "A tool for converting Excel files to SBOL (Synthetic Biology Open Language)
  format.\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
stdout: sbol-utilities_excel-to-sbol.out
