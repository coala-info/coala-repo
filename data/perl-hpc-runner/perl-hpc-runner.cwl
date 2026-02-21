cwlVersion: v1.2
class: CommandLineTool
baseCommand: hpcrunner.pl
label: perl-hpc-runner
doc: The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for perl-hpc-runner. As
  a result, arguments and specific tool descriptions could not be extracted from the
  input.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hpc-runner:2.48--0
stdout: perl-hpc-runner.out
