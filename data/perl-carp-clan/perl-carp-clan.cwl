cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-carp-clan
label: perl-carp-clan
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a Singularity/Docker container build failure
  due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/Carp::Clan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-carp-clan:6.08--pl5321hdfd78af_0
stdout: perl-carp-clan.out
