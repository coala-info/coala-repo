cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-base
label: perl-base
doc: "The perl-base package provides the bare minimum Perl interpreter. (Note: The
  provided input text is an execution error log and does not contain usage instructions
  or argument definitions).\n\nTool homepage: https://github.com/cmhughes/latexindent.pl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-base:2.23--pl526_1
stdout: perl-base.out
