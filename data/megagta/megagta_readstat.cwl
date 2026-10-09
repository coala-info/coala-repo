cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - megagta
  - readstat
label: megagta_readstat
doc: "Get sequence statistics (number of reads, total size, longest, shortest and
  average length) from a FASTQ or FASTA file read on standard input.\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
inputs:
  - id: input_fastq
    type: File
    doc: FASTQ or FASTA file, passed to the program on standard input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdin: $(inputs.input_fastq.path)
stdout: megagta_readstat.out
