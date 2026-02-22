cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-parallel-iterator
label: perl-parallel-iterator
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a failed container execution
  (Singularity/Docker) due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/Parallel::Iterator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-parallel-iterator:1.002--pl5321hdfd78af_0
stdout: perl-parallel-iterator.out
