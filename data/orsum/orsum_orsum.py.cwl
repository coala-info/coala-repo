cwlVersion: v1.2
class: CommandLineTool
baseCommand: orsum_orsum.py
label: orsum_orsum.py
doc: "The provided text contains error logs related to a container execution failure
  and does not include the help documentation for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/ozanozisik/orsum"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orsum:1.8.0--hdfd78af_0
stdout: orsum_orsum.py.out
