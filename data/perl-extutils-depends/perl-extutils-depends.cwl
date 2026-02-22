cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-extutils-depends
label: perl-extutils-depends
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to container image retrieval
  and disk space issues.\n\nTool homepage: http://gtk2-perl.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-extutils-depends:0.8002--pl5321hdfd78af_0
stdout: perl-extutils-depends.out
