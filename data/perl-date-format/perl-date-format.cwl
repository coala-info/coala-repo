cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-date-format
label: perl-date-format
doc: "A Perl utility for date formatting. (Note: The provided text contains execution
  logs indicating the executable was not found, rather than help text; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/landy22granatt/Kumpulan-Script-Termux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-date-format:2.30--pl5.22.0_0
stdout: perl-date-format.out
