cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-params-validate
label: perl-params-validate
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is a system error log indicating a failure to build or pull a Singularity/Apptainer
  container due to insufficient disk space ('no space left on device').\n\nTool homepage:
  http://metacpan.org/pod/Params-Validate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-params-validate:1.31--pl5321h7b50bb2_5
stdout: perl-params-validate.out
