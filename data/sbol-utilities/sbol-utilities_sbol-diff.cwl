cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sbol-diff
label: sbol-utilities_sbol-diff
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build or execution process.\n\nTool homepage:
  https://github.com/SynBioDex/SBOL-utilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbol-utilities:1.0a16--pyhdfd78af_0
stdout: sbol-utilities_sbol-diff.out
