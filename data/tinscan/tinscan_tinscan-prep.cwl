cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tinscan-prep
label: tinscan_tinscan-prep
doc: "A tool for preparing data for the Tandem Integration Scanner (tinscan).\n\n
  Tool homepage: https://github.com/Adamtaranto/TE-insertion-scanner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinscan:0.2.1--pyhdfd78af_0
stdout: tinscan_tinscan-prep.out
