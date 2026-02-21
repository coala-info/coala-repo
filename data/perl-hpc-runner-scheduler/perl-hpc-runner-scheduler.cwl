cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-hpc-runner-scheduler
label: perl-hpc-runner-scheduler
doc: 'A tool for scheduling and running HPC jobs (Note: The provided text was an error
  log and did not contain help information).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hpc-runner-scheduler:0.09--0
stdout: perl-hpc-runner-scheduler.out
