cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-config-any
label: perl-config-any
doc: "A Perl module that provides a facility for loading configuration from different
  file formats. (Note: The provided text contains system error messages regarding
  disk space and container building rather than CLI help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: http://metacpan.org/pod/Config-Any"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-config-any:0.33--pl5321h7b50bb2_5
stdout: perl-config-any.out
