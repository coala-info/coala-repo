cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-error
label: perl-error
doc: "The provided text does not contain help information or documentation for the
  'perl-error' tool. It consists of system error messages related to a failed container
  build (Singularity/Apptainer) due to insufficient disk space.\n\nTool homepage:
  http://metacpan.org/pod/Error"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-error:0.17030--pl5321hdfd78af_0
stdout: perl-error.out
