cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - trunc
label: seqhax_trunc
doc: "Truncate sequences. At least one of -l and -p must be given.\n\nTool homepage: https://github.com/kdmurray91/seqhax"
inputs:
  - id: input_file
    type: File
    doc: Sequence file in FASTA or FASTQ format (use /dev/stdin for standard input)
    inputBinding:
      position: 1
  - id: length
    type:
      - 'null'
      - int
    doc: Fixed (integer) length to truncate at.
    inputBinding:
      position: 102
      prefix: -l
  - id: proportion
    type:
      - 'null'
      - float
    doc: Truncate at PROP * length bases
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
stdout: seqhax_trunc.out
