cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sub-install
label: perl-sub-install
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating that the executable 'perl-sub-install' was not found in the system
  PATH during an Apptainer/Singularity execution.\n\nTool homepage: https://github.com/CNTRUN/Termux-command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sub-install:0.928--pl526_2
stdout: perl-sub-install.out
