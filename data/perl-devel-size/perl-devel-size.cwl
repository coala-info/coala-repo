cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-devel-size
label: perl-devel-size
doc: "Perl extension for finding the memory usage of Perl variables. (Note: The provided
  text contains system error messages regarding container image retrieval and does
  not contain help documentation or usage instructions.)\n\nTool homepage: http://metacpan.org/pod/Devel::Size"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-size:0.86--pl5321h87e0c26_0
stdout: perl-devel-size.out
