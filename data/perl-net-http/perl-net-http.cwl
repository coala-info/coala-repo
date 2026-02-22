cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-net-http
label: perl-net-http
doc: "Net::HTTP is a low-level HTTP client library for Perl. The provided text contains
  system error messages related to a failed container build and does not include CLI
  help documentation.\n\nTool homepage: https://github.com/libwww-perl/Net-HTTP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-net-http:6.24--pl5321hdfd78af_0
stdout: perl-net-http.out
