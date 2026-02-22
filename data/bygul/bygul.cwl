cwlVersion: v1.2
class: CommandLineTool
baseCommand: bygul
label: bygul
doc: "The provided text contains system error logs regarding container image retrieval
  and disk space issues rather than the tool's help documentation. As a result, no
  arguments or functional descriptions could be extracted.\n\nTool homepage: https://github.com/andersen-lab/Bygul"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bygul:1.0.7--pyhdfd78af_0
stdout: bygul.out
