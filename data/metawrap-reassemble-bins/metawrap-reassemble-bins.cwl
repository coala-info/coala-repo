cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap-reassemble-bins
label: metawrap-reassemble-bins
doc: "A tool for reassembling metagenomic bins to improve their quality (Note: The
  provided text contained only system error logs and no help information; therefore,
  no arguments could be extracted).\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-reassemble-bins:1.3.0--hdfd78af_3
stdout: metawrap-reassemble-bins.out
