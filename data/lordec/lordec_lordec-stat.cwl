cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordec-stat
label: lordec_lordec-stat
doc: "Reads the FASTA/Q file(s) of short reads, builds their de Bruijn graph for k-mers of the given length occurring at least the given number of times, and writes per-long-read statistics of solid k-mers.\n\nTool homepage: http://www.atgc-montpellier.fr/lordec/"
inputs:
  - id: long_reads
    type: File
    doc: long read FASTA/Q file
    inputBinding:
      position: 101
      prefix: -i
  - id: short_reads
    type:
      type: array
      items: File
    doc: short read FASTA/Q file(s)
    inputBinding:
      position: 102
      prefix: '-2'
  - id: kmer_len
    type: int
    doc: k-mer size
    inputBinding:
      position: 103
      prefix: -k
  - id: solid_threshold
    type: int
    doc: solid k-mer abundance threshold
    inputBinding:
      position: 104
      prefix: -s
  - id: stat_file_path
    type: string
    doc: out statistics file
    inputBinding:
      position: 105
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 106
      prefix: -T
outputs:
  - id: stat_file
    type: File
    doc: out statistics file
    outputBinding:
      glob: $(inputs.stat_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordec:0.9--h77376b9_3
