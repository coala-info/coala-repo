cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sbol-calculate-complexity
label: sbol-utilities_sbol-calculate-complexity
doc: "The provided text does not contain help information for the tool, but rather
  container runtime logs and a fatal error. No arguments could be extracted.\n\nTool
  homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
stdout: sbol-utilities_sbol-calculate-complexity.out
