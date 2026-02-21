cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-gdtextutil
label: perl-gdtextutil
doc: "The provided text does not contain help information for perl-gdtextutil; it
  is a log of a failed container build process (Apptainer/Singularity) due to insufficient
  disk space.\n\nTool homepage: https://github.com/gooselinux/perl-GDTextUtil"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-gdtextutil:0.86--pl5321h7b50bb2_9
stdout: perl-gdtextutil.out
