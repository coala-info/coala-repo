cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-getopt
label: perl-moosex-getopt
doc: "Moose role for processing command line options (Note: The provided text is an
  error log indicating a failure to pull the container image due to lack of disk space,
  rather than actual help text).\n\nTool homepage: https://github.com/moose/MooseX-Getopt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moosex-getopt:0.78--pl5321hdfd78af_0
stdout: perl-moosex-getopt.out
