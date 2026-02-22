cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-lwp-protocol-https
label: perl-lwp-protocol-https
doc: "LWP::Protocol::https - Provide HTTPS support for LWP::UserAgent (Note: The provided
  text contains system error logs rather than help documentation).\n\nTool homepage:
  https://metacpan.org/pod/LWP::Protocol::https"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-lwp-protocol-https:6.14--pl5321hdfd78af_1
stdout: perl-lwp-protocol-https.out
