cwlVersion: v1.2
class: CommandLineTool
baseCommand: py_fasta_validator
label: py_fasta_validator
doc: "Validate a fasta file. The exit code is 0 for a valid file, 1 when the first line
  does not start with >, 2 for duplicate sequence identifiers and 4 for characters
  other than letters in a sequence line; the reason is printed to the standard error.\n\
  \nTool homepage: https://github.com/linsalrob/py_fasta_validator"
inputs:
  - id: file
    type: File
    doc: fasta file to validate
    inputBinding:
      position: 1
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (reason when the file is not valid)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/py_fasta_validator:0.6--py312h734f728_7
successCodes: [0, 1, 2, 4]
stdout: py_fasta_validator.out
stderr: py_fasta_validator.err
