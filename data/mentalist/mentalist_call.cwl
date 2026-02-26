cwlVersion: v1.2
class: CommandLineTool
baseCommand: mentalist call
label: mentalist_call
doc: "Calls alleles on a given MLST database. You can create a custom DB with 'create_db'
  or other MentaLiST functions that download schemes from pubmlst, cgmlst.org or Enterobase.\n\
  \nTool homepage: https://github.com/WGS-TB/MentaLiST"
inputs:
  - id: db
    type: File
    doc: Kmer database
    inputBinding:
      position: 101
      prefix: --db
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Input files are in FASTA format, instead of the default FASTQs.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq_forward
    type:
      - 'null'
      - type: array
        items: File
    doc: FastQ input files, one per sample, forward reads (or unpaired reads).
    inputBinding:
      position: 101
      prefix: '-1'
  - id: fastq_reverse
    type:
      - 'null'
      - type: array
        items: File
    doc: FastQ input files, one per sample, reverse reads.
    inputBinding:
      position: 101
      prefix: '-2'
  - id: kt
    type:
      - 'null'
      - int
    doc: 'Minimum # of times a kmer is seen to be considered present in the sample
      (solid).'
    default: 10
    inputBinding:
      position: 101
      prefix: --kt
  - id: mutation_threshold
    type:
      - 'null'
      - int
    doc: Maximum number of mutations when looking for novel alleles.
    default: 6
    inputBinding:
      position: 101
      prefix: --mutation_threshold
  - id: output_special
    type:
      - 'null'
      - boolean
    doc: Outputs a FASTA file with the alleles from 'special cases' such as 
      incomplete coverage, novel, and multiple alleles.
    inputBinding:
      position: 101
      prefix: --output_special
  - id: output_votes
    type:
      - 'null'
      - boolean
    doc: Outputs the results for the original voting algorithm.
    inputBinding:
      position: 101
      prefix: --output_votes
  - id: sample_input_file
    type:
      - 'null'
      - File
    doc: Input TXT file for multiple samples. First column has the sample name, 
      second the FASTQ file. Repeat the sample name for samples with more than 
      one file (paired reads, f.i.)
    inputBinding:
      position: 101
      prefix: --sample_input_file
outputs:
  - id: output_file
    type: File
    doc: Output file with MLST call
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
