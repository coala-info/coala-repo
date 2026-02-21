cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sbol-calculate-sequences
label: sbol-utilities_sbol-calculate-sequences
doc: "A tool from the sbol-utilities suite. Note: The provided help text contains
  only container runtime error messages and does not list specific arguments or descriptions.\n
  \nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
stdout: sbol-utilities_sbol-calculate-sequences.out
