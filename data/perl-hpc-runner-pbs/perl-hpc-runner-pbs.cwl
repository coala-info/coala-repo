cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-hpc-runner-pbs
label: perl-hpc-runner-pbs
doc: The provided text does not contain help documentation or usage instructions for
  the tool. It appears to be an error log from an Apptainer/Singularity environment
  indicating that the executable was not found.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hpc-runner-pbs:0.12--0
stdout: perl-hpc-runner-pbs.out
