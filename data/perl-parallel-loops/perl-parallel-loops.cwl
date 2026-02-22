cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-parallel-loops
label: perl-parallel-loops
doc: "The provided text contains system error logs regarding a container image pull
  failure and does not include help documentation or usage instructions for the tool.\n\
  \nTool homepage: http://metacpan.org/pod/Parallel::Loops"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-parallel-loops:0.12--pl5321hdfd78af_0
stdout: perl-parallel-loops.out
