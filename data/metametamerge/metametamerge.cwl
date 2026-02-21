cwlVersion: v1.2
class: CommandLineTool
baseCommand: metametamerge
label: metametamerge
doc: "A tool for merging metagenomic taxonomic assignments (Note: The provided text
  contains system error logs rather than help documentation, so specific arguments
  could not be extracted).\n\nTool homepage: https://github.com/pirovc/metametamerge/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metametamerge:1.1--py35_1
stdout: metametamerge.out
