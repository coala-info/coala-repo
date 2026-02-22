cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-socket
label: perl-socket
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a Singularity/Apptainer container build
  failure due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/Socket"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-socket:2.027--pl5321h5c03b87_6
stdout: perl-socket.out
