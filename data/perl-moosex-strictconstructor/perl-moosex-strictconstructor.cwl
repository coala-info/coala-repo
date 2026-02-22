cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-strictconstructor
label: perl-moosex-strictconstructor
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is an error log indicating a failure to pull or build a Singularity/Docker
  container due to insufficient disk space ('no space left on device').\n\nTool homepage:
  http://metacpan.org/release/MooseX::StrictConstructor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-moosex-strictconstructor:0.21--pl5321hdfd78af_1
stdout: perl-moosex-strictconstructor.out
