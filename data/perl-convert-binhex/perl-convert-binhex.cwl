cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-convert-binhex
label: perl-convert-binhex
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a container execution log indicating that the executable was not found
  in the system path.\n\nTool homepage: https://github.com/pld-linux/perl-Convert-BinHex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-convert-binhex:1.125--0
stdout: perl-convert-binhex.out
