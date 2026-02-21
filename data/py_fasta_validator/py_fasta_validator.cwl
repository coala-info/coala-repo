cwlVersion: v1.2
class: CommandLineTool
baseCommand: py_fasta_validator
label: py_fasta_validator
doc: "A tool for validating FASTA files. (Note: The provided text appears to be a
  container engine error log rather than help text, so no arguments could be extracted.)\n
  \nTool homepage: https://github.com/linsalrob/py_fasta_validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-sphinxcontrib.autoprogram:v0.1.2-1-deb_cv1
stdout: py_fasta_validator.out
