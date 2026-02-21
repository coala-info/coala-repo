cwlVersion: v1.2
class: CommandLineTool
baseCommand: ispcr
label: ispcr
doc: "In-silico PCR tool. (Note: The provided text is a system error message regarding
  container image retrieval and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://users.soe.ucsc.edu/~kent/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ispcr:33--h7b50bb2_6
stdout: ispcr.out
