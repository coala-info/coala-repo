cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - ErrorRateByReadPosition
label: fgbio_ErrorRateByReadPosition
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
stdout: fgbio_ErrorRateByReadPosition.out
