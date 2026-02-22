cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-log-any
label: perl-log-any
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error messages related to a Singularity/Apptainer container pull
  failure (no space left on device).\n\nTool homepage: https://github.com/preaction/Log-Any"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-log-any:1.718--pl5321hdfd78af_0
stdout: perl-log-any.out
