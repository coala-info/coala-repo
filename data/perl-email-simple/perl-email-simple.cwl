cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-email-simple
label: perl-email-simple
doc: "Simple parsing of RFC2822 message format and headers. (Note: The provided text
  contains system error logs regarding disk space and container image conversion rather
  than command-line help documentation.)\n\nTool homepage: https://github.com/rjbs/Email-Simple"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-email-simple:2.218--hdfd78af_0
stdout: perl-email-simple.out
