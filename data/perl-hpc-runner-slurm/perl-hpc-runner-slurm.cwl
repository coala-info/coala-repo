cwlVersion: v1.2
class: CommandLineTool
baseCommand: hpc-runner-slurm
label: perl-hpc-runner-slurm
doc: The provided text does not contain help information or a description of the tool;
  it is an error log indicating a failure to build a container image due to insufficient
  disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hpc-runner-slurm:2.58--2
stdout: perl-hpc-runner-slurm.out
