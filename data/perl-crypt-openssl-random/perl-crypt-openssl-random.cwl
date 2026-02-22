cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-crypt-openssl-random
label: perl-crypt-openssl-random
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing due to insufficient disk space.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-crypt-openssl-random:0.11--pl5321hc234bb7_7
stdout: perl-crypt-openssl-random.out
