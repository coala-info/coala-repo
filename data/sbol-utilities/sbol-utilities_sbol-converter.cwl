cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sbol-converter
label: sbol-utilities_sbol-converter
doc: "A tool for converting between different SBOL (Synthetic Biology Open Language)
  versions and other genetic design formats.\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
stdout: sbol-utilities_sbol-converter.out
