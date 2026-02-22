cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-perlio-encoding
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log indicating a failure to pull or build
  a container image due to insufficient disk space ('no space left on device').\n\n\
  Tool homepage: https://github.com/salva/p5-PerlIO-encoding"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-perlio-encoding:0.18--pl5321hdfd78af_2
stdout: perl-perlio-encoding.out
