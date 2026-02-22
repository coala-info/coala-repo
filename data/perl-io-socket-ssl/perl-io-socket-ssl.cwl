cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-socket-ssl
label: perl-io-socket-ssl
doc: "Perl module that implements an interface to SSL/TLS using IO::Socket::IP or
  IO::Socket::INET. (Note: The provided text contains system error messages regarding
  disk space and container building rather than command-line help documentation.)\n\
  \nTool homepage: https://github.com/noxxi/p5-io-socket-ssl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-socket-ssl:2.074--pl5321hdfd78af_0
stdout: perl-io-socket-ssl.out
