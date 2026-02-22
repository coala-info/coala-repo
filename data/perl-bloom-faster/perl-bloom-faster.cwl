cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bloom-faster
label: perl-bloom-faster
doc: The provided text does not contain help information or usage instructions 
  for the tool. It consists of system error messages related to a failed 
  Singularity/Docker container build due to insufficient disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bloom-faster:1.7--pl5321h7b50bb2_8
stdout: perl-bloom-faster.out
