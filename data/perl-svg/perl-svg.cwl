cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-svg
label: perl-svg
doc: "A Perl extension for generating Scalable Vector Graphics (SVG) documents. Note:
  The provided text contains system error messages regarding container image retrieval
  and does not include CLI usage instructions.\n\nTool homepage: http://metacpan.org/pod/SVG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-svg:2.87--pl5321hdfd78af_0
stdout: perl-svg.out
