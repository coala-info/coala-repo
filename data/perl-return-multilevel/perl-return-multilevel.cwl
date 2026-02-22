cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-return-multilevel
label: perl-return-multilevel
doc: "The provided text does not contain help information or usage instructions. It
  is a system error log indicating a failure to build or pull a Singularity/SIF container
  due to insufficient disk space ('no space left on device').\n\nTool homepage: http://metacpan.org/pod/Return::MultiLevel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-return-multilevel:0.08--pl5321hdfd78af_0
stdout: perl-return-multilevel.out
