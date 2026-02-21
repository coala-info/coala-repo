cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgbio
label: fgbio
doc: "A set of tools for working with genomic data (Note: The provided text is a container
  runtime error log and does not contain help information or argument definitions).\n
  \nTool homepage: https://github.com/fulcrumgenomics/fgbio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgbio:3.1.1--hdfd78af_0
stdout: fgbio.out
