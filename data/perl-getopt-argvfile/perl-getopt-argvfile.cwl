cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-getopt-argvfile
label: perl-getopt-argvfile
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/pld-linux/perl-Getopt-ArgvFile"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-getopt-argvfile:1.11--pl5.22.0_0
stdout: perl-getopt-argvfile.out
