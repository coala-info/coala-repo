cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mailtools
label: perl-mailtools
doc: "The provided text does not contain help information or documentation for the
  tool. It consists of system error messages related to a Singularity/Docker container
  build failure due to insufficient disk space.\n\nTool homepage: https://metacpan.org/pod/MailTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mailtools:2.22--pl5321hdfd78af_0
stdout: perl-mailtools.out
