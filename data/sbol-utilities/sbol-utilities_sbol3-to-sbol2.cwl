cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sbol3-to-sbol2
label: sbol-utilities_sbol3-to-sbol2
doc: "A tool to convert SBOL3 files to SBOL2 format.\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
stdout: sbol-utilities_sbol3-to-sbol2.out
