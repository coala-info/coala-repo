cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-all
label: perl-io-all
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating that the executable 'perl-io-all' was not found in the system PATH.\n
  \nTool homepage: https://github.com/ingydotnet/io-all-pm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-all:0.87--pl526_0
stdout: perl-io-all.out
