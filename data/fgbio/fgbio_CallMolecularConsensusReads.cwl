cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - CallMolecularConsensusReads
label: fgbio_CallMolecularConsensusReads
doc: "Call molecular consensus reads. (Note: The provided text contains system error
  messages regarding container execution and does not include the actual help documentation
  for the tool.)\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
stdout: fgbio_CallMolecularConsensusReads.out
