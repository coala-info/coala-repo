cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-round
label: perl-math-round
doc: "A Perl module (Math::Round) for rounding numbers. (Note: The provided help text
  indicates a fatal error where the executable was not found in the PATH).\n\nTool
  homepage: https://github.com/pld-linux/perl-Math-Round"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-round:0.07--0
stdout: perl-math-round.out
