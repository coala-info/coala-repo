cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-matrix
label: perl-math-matrix
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container image pull failure (no space left
  on device).\n\nTool homepage: https://metacpan.org/pod/Math::Matrix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-matrix:0.94--pl5321hdfd78af_2
stdout: perl-math-matrix.out
