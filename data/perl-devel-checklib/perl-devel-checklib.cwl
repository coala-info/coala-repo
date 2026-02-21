cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-devel-checklib
label: perl-devel-checklib
doc: "The provided text does not contain help information for the tool. It consists
  of error logs from a failed container build process (Apptainer/Singularity) due
  to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/Devel-CheckLib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-checklib:1.16--pl5321h7b50bb2_1
stdout: perl-devel-checklib.out
