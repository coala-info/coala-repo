cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-data-munge
label: perl-data-munge
doc: "The provided text does not contain help documentation or usage instructions.
  It consists of system error messages related to a failed container image pull (Singularity/Apptainer)
  due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/Data::Munge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-data-munge:0.111--pl5321hdfd78af_0
stdout: perl-data-munge.out
