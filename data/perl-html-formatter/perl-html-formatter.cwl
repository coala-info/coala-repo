cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-html-formatter
label: perl-html-formatter
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating the executable was not found.\n\nTool homepage:
  https://metacpan.org/release/HTML-Formatter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-html-formatter:2.16--pl526_0
stdout: perl-html-formatter.out
