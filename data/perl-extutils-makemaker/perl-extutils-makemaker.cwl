cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-extutils-makemaker
label: perl-extutils-makemaker
doc: "The perl-extutils-makemaker tool was not found in the environment, and no help
  text was provided to parse.\n\nTool homepage: https://metacpan.org/release/ExtUtils-MakeMaker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-extutils-makemaker:7.36--pl526_1
stdout: perl-extutils-makemaker.out
