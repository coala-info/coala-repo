cwlVersion: v1.2
class: CommandLineTool
baseCommand: hpcrunner.pl
label: perl-hpc-runner-command_hpcrunner.pl
doc: "HPC::Runner::Command - Task runner for HPC systems. (Note: The provided text
  appears to be a container build error log rather than help text; no arguments could
  be extracted from the input.)\n\nTool homepage: https://github.com/biosails/HPC-Runner-Command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
stdout: perl-hpc-runner-command_hpcrunner.pl.out
