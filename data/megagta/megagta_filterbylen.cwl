cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - megagta
  - filterbylen
label: megagta_filterbylen
doc: "Filter contigs by length: reads a FASTA file on standard input and writes
  the contigs of at least the given length to standard output. A summary line is
  written to standard error.\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
inputs:
  - id: contigs
    type: File
    doc: Contigs in FASTA format, passed to the program on standard input
  - id: min_len
    type: int
    doc: Minimum contig length
    inputBinding:
      position: 1
outputs:
  - id: filtered_contigs
    type: stdout
    doc: Contigs of at least the minimum length, in FASTA format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdin: $(inputs.contigs.path)
stdout: megagta_filterbylen.fa
