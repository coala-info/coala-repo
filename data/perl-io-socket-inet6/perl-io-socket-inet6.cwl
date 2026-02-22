cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-socket-inet6
label: perl-io-socket-inet6
doc: "IO::Socket::INET6 provides an object interface to creating and using sockets
  in both AF_INET and AF_INET6 domains. It is a Perl module used for IPv6 support.\n\
  \nTool homepage: http://metacpan.org/pod/IO::Socket::INET6"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-io-socket-inet6:2.73--pl5321hdfd78af_0
stdout: perl-io-socket-inet6.out
