cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-libxml-perl
label: perl-libxml-perl
doc: "The provided text is an error log indicating that the executable 'perl-libxml-perl'
  was not found in the system PATH. No help text or usage information was available
  to parse arguments.\n\nTool homepage: https://github.com/grantm/perl-libxml-by-example"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-libxml-perl:0.08--0
stdout: perl-libxml-perl.out
