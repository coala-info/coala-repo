cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-das
label: perl-bio-das
doc: "The provided text does not contain help information for the tool. It contains
  system logs indicating a failure to build or run a container image due to insufficient
  disk space.\n\nTool homepage: http://metacpan.org/pod/Bio::Das"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-das:1.17--0
stdout: perl-bio-das.out
