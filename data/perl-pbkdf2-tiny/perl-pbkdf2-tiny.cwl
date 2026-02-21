cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pbkdf2-tiny
label: perl-pbkdf2-tiny
doc: 'A tiny Perl implementation of PBKDF2 (Password-Based Key Derivation Function
  2). Note: The provided help text indicates an execution error and does not contain
  usage information.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pbkdf2-tiny:0.005--pl526_1
stdout: perl-pbkdf2-tiny.out
