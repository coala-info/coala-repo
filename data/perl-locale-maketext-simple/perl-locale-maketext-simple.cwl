cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-locale-maketext-simple
label: perl-locale-maketext-simple
doc: "The provided text does not contain help information. It is an error log indicating
  that the executable 'perl-locale-maketext-simple' was not found in the system PATH
  during an Apptainer/Singularity build process.\n\nTool homepage: https://github.com/pld-linux/perl-Locale-Maketext-Simple"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-locale-maketext-simple:0.21--pl5.22.0_0
stdout: perl-locale-maketext-simple.out
