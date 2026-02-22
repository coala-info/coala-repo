cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-namespace-autoclean
label: perl-namespace-autoclean
doc: "A Perl module that cleans imported symbols from your namespace. (Note: The provided
  text contains system error messages regarding disk space and container image conversion
  rather than CLI help documentation.)\n\nTool homepage: https://github.com/moose/namespace-autoclean"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-namespace-autoclean:0.31--pl5321h9948957_2
stdout: perl-namespace-autoclean.out
