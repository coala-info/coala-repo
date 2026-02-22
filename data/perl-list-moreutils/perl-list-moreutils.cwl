cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-list-moreutils
label: perl-list-moreutils
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a failed container image build (Singularity/Apptainer)
  due to insufficient disk space.\n\nTool homepage: https://metacpan.org/release/List-MoreUtils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-list-moreutils:0.430--pl5321hdfd78af_0
stdout: perl-list-moreutils.out
