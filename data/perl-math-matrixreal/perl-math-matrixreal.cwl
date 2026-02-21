cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-matrixreal
label: perl-math-matrixreal
doc: "The provided text does not contain help documentation as the executable was
  not found in the environment. Math::MatrixReal is typically a Perl library for manipulating
  nxn matrices of real numbers.\n\nTool homepage: http://metacpan.org/pod/Math::MatrixReal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-matrixreal:2.13--pl526_0
stdout: perl-math-matrixreal.out
