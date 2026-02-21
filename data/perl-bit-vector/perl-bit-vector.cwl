cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bit-vector
label: perl-bit-vector
doc: "The executable 'perl-bit-vector' was not found in the system PATH, and no help
  text was provided to extract arguments.\n\nTool homepage: https://github.com/naoya/perl-bit-vector-succinct"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bit-vector:7.4--pl526_1
stdout: perl-bit-vector.out
