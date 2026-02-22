cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-unicode-utf8
label: perl-unicode-utf8
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a failed container build due to insufficient
  disk space.\n\nTool homepage: http://metacpan.org/pod/Unicode::UTF8"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-unicode-utf8:0.62--pl5321h9948957_8
stdout: perl-unicode-utf8.out
