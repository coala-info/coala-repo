cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-extutils-constant
label: perl-extutils-constant
doc: "A Perl utility for generating C code for constants. (Note: The provided input
  text was an error log indicating the executable was not found, so no specific help
  text or arguments could be parsed.)\n\nTool homepage: http://metacpan.org/pod/ExtUtils::Constant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-extutils-constant:0.25--pl526h14c3975_0
stdout: perl-extutils-constant.out
