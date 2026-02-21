cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaindex
label: fastaindex
doc: "The provided text contains system error messages related to a container runtime
  failure and does not include the tool's help documentation or usage instructions.\n
  \nTool homepage: https://github.com/lpryszcz/FastaIndex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaindex:0.11c--py27_0
stdout: fastaindex.out
