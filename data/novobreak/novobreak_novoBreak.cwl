cwlVersion: v1.2
class: CommandLineTool
baseCommand: novoBreak
label: novobreak_novoBreak
doc: "a tool for discovering somatic sv breakpoints\n\nTool homepage: https://github.com/czc/nb_distribution"
inputs:
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size, <=31
    inputBinding:
      position: 101
      prefix: -k
  - id: min_kmer_count
    type:
      - 'null'
      - int
    doc: Minimum kmer count regarded as novo kmers
    inputBinding:
      position: 101
      prefix: -m
  - id: normal_bam
    type: File
    doc: Normal bam file
    inputBinding:
      position: 101
      prefix: -c
  - id: output_germline_events
    type:
      - 'null'
      - int
    doc: Output germline events
    inputBinding:
      position: 101
      prefix: -g
  - id: reference
    type: File
    doc: Reference file in fasta format
    inputBinding:
      position: 101
      prefix: -r
  - id: tumor_bam
    type: File
    doc: Tumor bam file
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: output_kmer
    type: File
    doc: Output kmer
    outputBinding:
      glob: $(inputs.output_kmer)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novobreak:1.1.3rc--h7132678_8
