cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophex
  - bwtdowngrade
label: prophex_bwtdowngrade
doc: "Downgrades a BWT index to an older version.\n\nTool homepage: https://github.com/prophyle/prophex"
inputs:
  - id: input_bwt
    type: File
    doc: Input BWT index file
    inputBinding:
      position: 1
outputs:
  - id: output_bwt
    type: File
    doc: Output BWT index file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophex:0.1.1--h5bf99c6_2
