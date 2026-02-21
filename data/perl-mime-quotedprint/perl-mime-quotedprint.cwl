cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mime-quotedprint
label: perl-mime-quotedprint
doc: 'A tool for encoding and decoding quoted-printable strings (Note: The provided
  help text contains no usage information as the executable was not found).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mime-quotedprint:3.13--pl5.22.0_0
stdout: perl-mime-quotedprint.out
