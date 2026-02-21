cwlVersion: v1.2
class: CommandLineTool
baseCommand: go-stats.pl
label: perl-go-perl_go-stats.pl
doc: "A tool from the perl-go-perl package. (Note: The provided input text is a system
  error log regarding a failed container build due to insufficient disk space and
  does not contain the actual help text or usage instructions for the tool.)\n\nTool
  homepage: http://metacpan.org/pod/go-perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-go-perl:0.15--pl526_3
stdout: perl-go-perl_go-stats.pl.out
