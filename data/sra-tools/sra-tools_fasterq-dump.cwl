cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasterq-dump
label: sra-tools_fasterq-dump
doc: "The provided text does not contain help information or documentation for the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/ncbi/sra-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
stdout: sra-tools_fasterq-dump.out
