cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sbol-utilities
  - fasta-to-sbol
label: sbol-utilities_fasta-to-sbol
doc: "Convert FASTA files to SBOL (Note: The provided help text contains only system
  error logs and no usage information; arguments could not be extracted from the source
  text).\n\nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
stdout: sbol-utilities_fasta-to-sbol.out
