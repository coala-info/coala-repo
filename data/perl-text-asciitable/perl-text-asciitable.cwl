cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-text-asciitable
label: perl-text-asciitable
doc: "A Perl module to create a nice formatted table using ASCII characters. (Note:
  The provided text is a container build error log and does not contain CLI help information.)\n
  \nTool homepage: https://github.com/pld-linux/perl-Text-ASCIITable"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-asciitable:0.22--pl526_1
stdout: perl-text-asciitable.out
