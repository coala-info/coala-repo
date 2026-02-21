cwlVersion: v1.2
class: CommandLineTool
baseCommand: elastic-blast
label: elastic-blast
doc: "ElasticBLAST is a tool for running BLAST searches in the cloud. (Note: The provided
  text is a container execution error log and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: https://pypi.org/project/elastic-blast/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0
stdout: elastic-blast.out
