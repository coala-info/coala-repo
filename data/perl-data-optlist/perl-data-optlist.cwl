cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-data-optlist
label: perl-data-optlist
doc: "A Perl module (Data::OptList) for parsing and validating simple name/value option
  pairs. Note: The provided text contains system error messages regarding disk space
  and container image retrieval rather than tool usage instructions.\n\nTool homepage:
  https://github.com/rjbs/Data-OptList"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-data-optlist:0.112--pl5321hdfd78af_0
stdout: perl-data-optlist.out
