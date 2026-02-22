cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-moo
doc: "Moo is an extremely light-weight Object Orientation system for Perl. The provided
  text appears to be a system error log from a container runtime (Singularity/Apptainer)
  rather than the tool's help documentation.\n\nTool homepage: http://metacpan.org/pod/Moo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moo:2.005004--pl5321hdfd78af_0
stdout: perl-moo.out
