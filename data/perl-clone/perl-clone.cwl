cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-clone
label: perl-clone
doc: "The provided text does not contain help information or usage instructions; it
  contains system error messages (WARNING, INFO, FATAL) regarding a failure to pull
  or build a Singularity container due to insufficient disk space.\n\nTool homepage:
  http://metacpan.org/pod/Clone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-clone:0.46--pl5321hec16e2b_0
stdout: perl-clone.out
