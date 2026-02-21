cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-statistics-frequency
label: perl-statistics-frequency
doc: "A Perl module/tool for managing frequency distributions of data. (Note: The
  provided help text indicates an execution error: 'executable file not found in $PATH')\n
  \nTool homepage: https://github.com/ajay04323/cpanel_CPSP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-statistics-frequency:0.04--1
stdout: perl-statistics-frequency.out
