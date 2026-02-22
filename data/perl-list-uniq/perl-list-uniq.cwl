cwlVersion: v1.2
class: CommandLineTool
baseCommand: list-uniq
label: perl-list-uniq
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull a Docker image due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/List::Uniq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-list-uniq:0.23--pl5321hdfd78af_0
stdout: perl-list-uniq.out
