cwlVersion: v1.2
class: CommandLineTool
baseCommand: cover
label: perl-devel-cover
doc: "A tool to generate code coverage reports for Perl via Devel::Cover.\n\nTool
  homepage: http://www.pjcj.net/perl.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-cover:1.33--pl526h14c3975_0
stdout: perl-devel-cover.out
