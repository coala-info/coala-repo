cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-spiffy
label: perl-spiffy
doc: "Spiffy (Syntactic Portability Interface For Flexibly Yakking) is a framework
  for doing object oriented (OO) programming in Perl.\n\nTool homepage: https://github.com/ingydotnet/spiffy-pm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-spiffy:0.46--pl526_3
stdout: perl-spiffy.out
