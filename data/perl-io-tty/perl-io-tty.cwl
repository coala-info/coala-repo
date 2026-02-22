cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-tty
label: perl-io-tty
doc: "Perl interface to pseudo-ttys (Note: The provided text contains system error
  logs regarding container image retrieval and does not contain help documentation
  for the tool itself).\n\nTool homepage: http://metacpan.org/pod/IO-Tty"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-tty:1.16--pl5321hec16e2b_1
stdout: perl-io-tty.out
