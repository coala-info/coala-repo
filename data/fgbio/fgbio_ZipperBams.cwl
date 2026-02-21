cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fgbio
  - ZipperBams
label: fgbio_ZipperBams
doc: "The provided text contains system error messages and does not include the help
  documentation for fgbio ZipperBams. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
stdout: fgbio_ZipperBams.out
