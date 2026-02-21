cwlVersion: v1.2
class: CommandLineTool
baseCommand: rambo-k
label: rambo-k
doc: "RAMBO-K (Read Assignment Method Based on K-mers) is a tool for rapid and sensitive
  taxonomic assignment of NGS reads to one of two reference genomes.\n\nTool homepage:
  https://gitlab.com/SimonHTausch/RAMBO-K"
inputs:
  - id: amount_of_reads
    type:
      - 'null'
      - int
    doc: Number of reads to be used for calculating the distribution of k-mers.
    inputBinding:
      position: 101
      prefix: -a
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: The size of the k-mers.
    default: 12
    inputBinding:
      position: 101
      prefix: -k
  - id: reads_1
    type: File
    doc: Fastq file containing the (forward) reads.
    inputBinding:
      position: 101
      prefix: -r1
  - id: reads_2
    type:
      - 'null'
      - File
    doc: Fastq file containing the reverse reads (optional).
    inputBinding:
      position: 101
      prefix: -r2
  - id: reference_1
    type: File
    doc: Fasta file containing the reference genome of species 1.
    inputBinding:
      position: 101
      prefix: -ref1
  - id: reference_2
    type: File
    doc: Fasta file containing the reference genome of species 2.
    inputBinding:
      position: 101
      prefix: -ref2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: The directory where the results should be written.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rambo-k:1.21--py36_0
