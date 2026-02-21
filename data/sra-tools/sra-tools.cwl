cwlVersion: v1.2
class: CommandLineTool
baseCommand: sra-tools
label: sra-tools
doc: "The provided text is a container build log/error message and does not contain
  help documentation or usage instructions for the tool.\n\nTool homepage: https://github.com/ncbi/sra-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
stdout: sra-tools.out
