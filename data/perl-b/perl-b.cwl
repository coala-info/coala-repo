cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-b
label: perl-b
doc: "The provided text does not contain help information for 'perl-b'. It appears
  to be an error log indicating that the executable was not found in the environment.\n
  \nTool homepage: https://github.com/chromatic/modern_perl_book"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-b:1.48--pl526_1
stdout: perl-b.out
