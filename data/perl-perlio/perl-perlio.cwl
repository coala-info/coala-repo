cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-perlio
label: perl-perlio
doc: "Perl extension for PerlIO layers (Note: The provided text is an error log indicating
  the executable was not found; no usage information or arguments were provided in
  the input).\n\nTool homepage: https://github.com/gfx/Perl-PerlIO-Util"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-perlio:1.09--pl526_1
stdout: perl-perlio.out
