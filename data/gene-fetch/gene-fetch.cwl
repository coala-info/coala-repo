cwlVersion: v1.2
class: CommandLineTool
baseCommand: gene-fetch
label: gene-fetch
doc: "A tool for fetching gene-related data. (Note: The provided text contains system
  error logs and does not include usage instructions or argument definitions.)\n\n
  Tool homepage: https://github.com/bge-barcoding/gene_fetch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gene-fetch:1.0.21--pyhdfd78af_0
stdout: gene-fetch.out
