cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbol-expand-derivations
label: sbol-utilities_sbol-expand-derivations
doc: "The provided text does not contain help information for the tool. It contains
  container environment logs and a fatal error message regarding a build failure.\n
  \nTool homepage: https://github.com/SynBioDex/SBOL-utilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
stdout: sbol-utilities_sbol-expand-derivations.out
