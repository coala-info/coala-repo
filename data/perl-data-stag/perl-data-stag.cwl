cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-data-stag
label: perl-data-stag
doc: "The provided text does not contain help documentation for the tool; it consists
  of system logs from an Apptainer/Singularity build process that failed due to insufficient
  disk space.\n\nTool homepage: https://github.com/OpenMandrivaAssociation/perl-Data-Stag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-data-stag:0.14--pl526_1
stdout: perl-data-stag.out
