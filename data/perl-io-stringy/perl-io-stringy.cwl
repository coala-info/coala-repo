cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-stringy
label: perl-io-stringy
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log indicating that the executable 'perl-io-stringy' was
  not found in the system PATH.\n\nTool homepage: https://github.com/gooselinux/perl-IO-stringy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-stringy:2.111--pl526_1
stdout: perl-io-stringy.out
