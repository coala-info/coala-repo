cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-dbd-pg
label: perl-dbd-pg
doc: "The provided text does not contain help information or usage instructions for
  the tool; it consists of system logs from a failed container build/fetch process
  (Apptainer/Singularity) due to insufficient disk space.\n\nTool homepage: http://search.cpan.org/dist/DBD-Pg/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-dbd-pg:3.18.0--pl5321h3a0becb_3
stdout: perl-dbd-pg.out
