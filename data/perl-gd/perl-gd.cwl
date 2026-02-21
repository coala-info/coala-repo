cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-gd
doc: "The provided text is a system error log regarding a failed container build (no
  space left on device) and does not contain CLI help documentation for the perl-gd
  tool. perl-gd is typically a Perl module (GD.pm) providing an interface to the GD
  graphics library.\n\nTool homepage: http://metacpan.org/pod/GD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-gd:2.84--pl5321hc25ab4d_0
stdout: perl-gd.out
