cwlVersion: v1.2
class: CommandLineTool
baseCommand: heinz
label: heinz
doc: "Heuristic Identification of Network Modules (Note: The provided text contains
  error logs from a container runtime and does not include the tool's help documentation.
  No arguments could be extracted.)\n\nTool homepage: https://github.com/ls-cwi/heinz"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/heinz:2.0.1--h503566f_5
stdout: heinz.out
