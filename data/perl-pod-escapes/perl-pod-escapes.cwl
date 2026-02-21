cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pod-escapes
label: perl-pod-escapes
doc: "The provided text does not contain help documentation. It is an error log indicating
  that the executable 'perl-pod-escapes' was not found in the system PATH during an
  Apptainer/Singularity build process.\n\nTool homepage: https://github.com/pld-linux/perl-Pod-Escapes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pod-escapes:1.07--pl526_1
stdout: perl-pod-escapes.out
