cwlVersion: v1.2
class: CommandLineTool
baseCommand: sibsim4
label: sibsim4
doc: 'Spliced alignment of expressed RNA sequences (EST, mRNA) against a genomic sequence.
  (Note: The provided text contains system error messages regarding container execution
  and does not list command-line arguments.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sibsim4:v0.20-4-deb_cv1
stdout: sibsim4.out
