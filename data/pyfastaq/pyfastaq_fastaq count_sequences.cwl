cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyfastaq
  - fastaq
  - count_sequences
label: pyfastaq_fastaq count_sequences
doc: "Count the number of sequences in a FASTA or FASTQ file.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA or FASTQ file.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
stdout: pyfastaq_fastaq count_sequences.out
