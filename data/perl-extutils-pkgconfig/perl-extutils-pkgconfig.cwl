cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-extutils-pkgconfig
label: perl-extutils-pkgconfig
doc: "A Perl interface to the pkg-config utility (Note: The provided text is an error
  log indicating the executable was not found, so no help text was available for parsing
  arguments).\n\nTool homepage: http://gtk2-perl.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-extutils-pkgconfig:1.16--pl526_1
stdout: perl-extutils-pkgconfig.out
