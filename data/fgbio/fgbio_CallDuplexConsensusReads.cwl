cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - CallDuplexConsensusReads
label: fgbio_CallDuplexConsensusReads
doc: "The provided text does not contain help information for the tool, but rather
  a system error message indicating a failure to build the container image due to
  lack of disk space.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
stdout: fgbio_CallDuplexConsensusReads.out
