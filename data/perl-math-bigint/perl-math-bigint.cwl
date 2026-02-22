cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-bigint
label: perl-math-bigint
doc: "Arbitrary size integer math package (Note: The provided text contains system
  error messages regarding container extraction and does not include CLI usage instructions).\n\
  \nTool homepage: http://metacpan.org/pod/Math::BigInt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-math-bigint:2.005003--pl5321hdfd78af_0
stdout: perl-math-bigint.out
