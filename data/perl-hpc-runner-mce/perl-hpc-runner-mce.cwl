cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-hpc-runner-mce
label: perl-hpc-runner-mce
doc: The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed execution attempt where the executable was not found
  in the environment.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hpc-runner-mce:2.41--0
stdout: perl-hpc-runner-mce.out
