cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-getopt-long
label: perl-getopt-long
doc: "The provided text contains system error messages related to a container runtime
  (Singularity/Apptainer) failing to pull a container image due to lack of disk space,
  rather than the help text for the tool itself. Getopt::Long is a Perl module for
  parsing command-line options.\n\nTool homepage: http://metacpan.org/pod/Getopt::Long"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-getopt-long:2.58--pl5321hdfd78af_0
stdout: perl-getopt-long.out
