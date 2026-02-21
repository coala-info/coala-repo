cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-jcode
label: perl-jcode
doc: "A tool for Japanese character set conversion in Perl. (Note: The provided text
  indicates a fatal error where the executable was not found, so no specific help
  documentation or arguments could be parsed from the input.)\n\nTool homepage: https://github.com/pld-linux/perl-Jcode"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-jcode:2.07--0
stdout: perl-jcode.out
