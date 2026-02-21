cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - FastqToBam
label: fgbio_FastqToBam
doc: "The provided text does not contain a description of the tool as it appears to
  be a system error log indicating a 'no space left on device' failure during container
  image extraction.\n\nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
stdout: fgbio_FastqToBam.out
