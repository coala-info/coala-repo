cwlVersion: v1.2
class: CommandLineTool
baseCommand: metfrag-cli-batch
label: metfrag-cli-batch
doc: "MetFrag command line interface for batch processing. Note: The provided text
  contains error logs rather than help documentation, so no arguments could be extracted.\n
  \nTool homepage: http://c-ruttkies.github.io/MetFrag/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/metfrag-cli-batch:v2.4.3_cv0.6
stdout: metfrag-cli-batch.out
