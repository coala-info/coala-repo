cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - count_sequences
label: pyfastaq_fastaq_count_sequences
doc: "Prints the number of sequences in input file to stdout\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 20
outputs:
  - id: sequence_count
    type: stdout
    doc: Number of sequences, printed on standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
stdout: pyfastaq_fastaq_count_sequences.out
