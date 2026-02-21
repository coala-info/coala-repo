cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-dbd-mysql
label: perl-dbd-mysql
doc: "The provided text is an error log from a container build process and does not
  contain CLI help information or usage instructions for the tool.\n\nTool homepage:
  https://dbi.perl.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-dbd-mysql:5.013--pl5321h0a44790_0
stdout: perl-dbd-mysql.out
