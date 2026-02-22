cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-yaml-pp
label: perl-yaml-pp
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding disk space issues during a container execution.\n\
  \nTool homepage: http://metacpan.org/pod/YAML::PP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-yaml-pp:0.39.0--pl5321hdfd78af_0
stdout: perl-yaml-pp.out
