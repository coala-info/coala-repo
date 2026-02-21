cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-hpc-runner-command
label: perl-hpc-runner-command
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container image build
  failure (no space left on device).\n\nTool homepage: https://github.com/biosails/HPC-Runner-Command"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
stdout: perl-hpc-runner-command.out
