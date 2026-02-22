cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-http-message
label: perl-http-message
doc: "The provided text contains system error messages related to a Singularity/Docker
  image pull failure and does not contain help documentation or usage instructions
  for the tool. perl-http-message is typically a Perl library (HTTP::Message) providing
  a base class for HTTP style messages.\n\nTool homepage: https://github.com/libwww-perl/HTTP-Message"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-http-message:7.01--pl5321hdfd78af_0
stdout: perl-http-message.out
