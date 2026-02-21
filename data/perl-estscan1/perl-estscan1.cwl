cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-estscan1
label: perl-estscan1
doc: The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help text or usage information for the tool 'perl-estscan1'.
  As a result, no arguments could be extracted.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-estscan1:1.3--pl526_1
stdout: perl-estscan1.out
