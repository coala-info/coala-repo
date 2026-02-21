cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-gd-svg
label: perl-gd-svg
doc: "No description available: The provided text is a container build error log rather
  than help text.\n\nTool homepage: http://metacpan.org/pod/GD::SVG"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-gd-svg:0.33--pl5321hdfd78af_2
stdout: perl-gd-svg.out
