cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-specio
label: perl-specio
doc: "A Perl module that provides a system for defining and using type constraints.
  (Note: The provided text contains system error messages regarding container image
  conversion and does not include CLI help documentation.)\n\nTool homepage: http://metacpan.org/release/Specio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-specio:0.53--pl5321hdfd78af_0
stdout: perl-specio.out
