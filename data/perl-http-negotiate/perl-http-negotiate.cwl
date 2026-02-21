cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-http-negotiate
label: perl-http-negotiate
doc: "Perl implementation of HTTP content negotiation\n\nTool homepage: https://github.com/pld-linux/perl-HTTP-Negotiate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-http-negotiate:6.01--pl526_1
stdout: perl-http-negotiate.out
