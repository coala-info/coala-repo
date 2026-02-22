cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-heap-simple-xs
label: perl-heap-simple-xs
doc: The provided text does not contain help documentation or usage 
  instructions. It consists of system error messages related to a failed 
  Singularity/Docker image pull due to insufficient disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-heap-simple-xs:0.10--pl5321h7b50bb2_8
stdout: perl-heap-simple-xs.out
