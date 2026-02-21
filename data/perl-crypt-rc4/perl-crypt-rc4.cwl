cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-crypt-rc4
label: perl-crypt-rc4
doc: "Perl implementation of the RC4 encryption algorithm\n\nTool homepage: https://github.com/pld-linux/perl-Crypt-RC4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-crypt-rc4:2.02--pl526_1
stdout: perl-crypt-rc4.out
