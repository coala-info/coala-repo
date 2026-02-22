cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-socket6
label: perl-socket6
doc: "The provided text is a system error log regarding a failed Singularity/Docker
  image pull and does not contain CLI help information or argument definitions.\n\n\
  Tool homepage: http://metacpan.org/pod/Socket6"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-socket6:0.29--pl5321h7b50bb2_6
stdout: perl-socket6.out
