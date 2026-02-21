cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sbol-utilities
  - sbol-to-genbank
label: sbol-utilities_sbol-to-genbank
doc: "Convert SBOL files to GenBank format\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
stdout: sbol-utilities_sbol-to-genbank.out
