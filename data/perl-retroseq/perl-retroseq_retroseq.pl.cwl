cwlVersion: v1.2
class: CommandLineTool
baseCommand: retroseq.pl
label: perl-retroseq_retroseq.pl
doc: "The provided text does not contain help information for the tool. It contains
  system log messages indicating a failure to build or extract a container image due
  to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/tk2/RetroSeq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-retroseq:1.5--pl5321h7181c03_3
stdout: perl-retroseq_retroseq.pl.out
