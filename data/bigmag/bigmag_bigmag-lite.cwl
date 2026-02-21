cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigmag-lite
label: bigmag_bigmag-lite
doc: "The provided text is an error log from a container build process and does not
  contain help information or usage instructions for the tool. As a result, arguments
  and a functional description cannot be extracted.\n\nTool homepage: https://github.com/jeffe107/BIgMAG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigmag:1.1.0--pyhdfd78af_0
stdout: bigmag_bigmag-lite.out
