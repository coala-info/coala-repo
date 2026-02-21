cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-sereal
doc: "Sereal is a high-performance binary serialization format for Perl. The provided
  text appears to be a system error log from a container runtime (Apptainer/Singularity)
  rather than the tool's help documentation.\n\nTool homepage: https://metacpan.org/pod/Sereal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sereal:5.004--pl5321hdfd78af_0
stdout: perl-sereal.out
