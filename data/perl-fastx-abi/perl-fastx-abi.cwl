cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-fastx-abi
label: perl-fastx-abi
doc: "A tool for calculating the Assembly Base Index (ABI) from FASTX files. (Note:
  The provided text contains system error messages regarding disk space and container
  extraction rather than the tool's help documentation.)\n\nTool homepage: https://github.com/telatin/FASTX-Abi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fastx-abi:1.0.1--pl5321hdfd78af_1
stdout: perl-fastx-abi.out
