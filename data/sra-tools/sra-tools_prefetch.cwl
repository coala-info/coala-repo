cwlVersion: v1.2
class: CommandLineTool
baseCommand: prefetch
label: sra-tools_prefetch
doc: "The provided text does not contain help information or usage instructions for
  sra-tools_prefetch. It appears to be a log of a failed container build process.\n
  \nTool homepage: https://github.com/ncbi/sra-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sra-tools:3.2.1--h4304569_1
stdout: sra-tools_prefetch.out
