cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-cairo
label: perl-cairo
doc: "Perl interface to the Cairo 2D graphics library. (Note: The provided text contains
  error logs from a container build process and does not include CLI help documentation
  or argument definitions.)\n\nTool homepage: http://gtk2-perl.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-cairo:1.109--pl5321hb0b1468_2
stdout: perl-cairo.out
