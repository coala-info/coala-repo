cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - kmer_query
label: rgi_rgi kmer_query
doc: "Tests sequenes using CARD*kmers\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_file
    type: File
    doc: Input file (bam file from RGI*BWT, json file of RGI results, fasta file
      of sequences)
    inputBinding:
      position: 101
      prefix: --input
  - id: kmer_size
    type: int
    doc: length of k
    inputBinding:
      position: 101
      prefix: --kmer_size
  - id: minimum_kmers
    type:
      - 'null'
      - int
    doc: Minimum number of kmers in the called category for the classification 
      to be made
    default: 10
    inputBinding:
      position: 101
      prefix: --minimum
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (CPUs) to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_fasta_sequences
    type:
      - 'null'
      - boolean
    doc: Specify if the input file is a fasta file of sequences
    inputBinding:
      position: 101
      prefix: --fasta
  - id: use_local_database
    type:
      - 'null'
      - boolean
    doc: use local database
    default: uses database in executable directory
    inputBinding:
      position: 101
      prefix: --local
  - id: use_rgi_bwt_bam
    type:
      - 'null'
      - boolean
    doc: Specify if the input file for analysis is a bam file generated from 
      RGI*BWT
    inputBinding:
      position: 101
      prefix: --bwt
  - id: use_rgi_results_json
    type:
      - 'null'
      - boolean
    doc: Specify if the input file is a RGI results json file
    inputBinding:
      position: 101
      prefix: --rgi
outputs:
  - id: output_file
    type: File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
