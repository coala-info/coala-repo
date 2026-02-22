cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-biox-seq
label: perl-biox-seq
doc: "The provided text contains system error messages related to a container execution
  failure ('no space left on device') and does not contain the help documentation
  or usage instructions for the tool. As a result, no arguments could be extracted.\n\
  \nTool homepage: http://metacpan.org/pod/BioX::Seq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-biox-seq:0.008009--pl5321hdfd78af_0
stdout: perl-biox-seq.out
