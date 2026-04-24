cwlVersion: v1.2
class: CommandLineTool
baseCommand: boquila
label: boquila
doc: "Generate NGS reads with same nucleotide distribution as input file. Generated
  reads will be written to stdout. By default input and output format is FASTQ.\n\n
  Tool homepage: https://github.com/CompGenomeLab/boquila"
inputs:
  - id: src
    type: File
    doc: Model file
    inputBinding:
      position: 1
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Change input and output format to FASTA
    inputBinding:
      position: 102
      prefix: --fasta
  - id: inseq
    type:
      - 'null'
      - File
    doc: Input sequencing reads to be used instead of reference genome
    inputBinding:
      position: 102
      prefix: --inseq
  - id: inseq_fasta
    type:
      - 'null'
      - boolean
    doc: Change the input sequencing format to FASTA
    inputBinding:
      position: 102
      prefix: --inseqFasta
  - id: kmer
    type:
      - 'null'
      - int
    doc: Kmer size to be used while calculating frequency
    inputBinding:
      position: 102
      prefix: --kmer
  - id: qual
    type:
      - 'null'
      - string
    doc: Quality score to be applied to to each position for all reads. 'setQual'
      flag should be present in order it to work. Has no effect if input reads are
      not in FASTQ format.
    inputBinding:
      position: 102
      prefix: --qual
  - id: ref
    type:
      - 'null'
      - File
    doc: Reference FASTA
    inputBinding:
      position: 102
      prefix: --ref
  - id: regions
    type:
      - 'null'
      - File
    doc: RON formatted file containing genomic regions that generated reads will be
      selected from
    inputBinding:
      position: 102
      prefix: --regions
  - id: seed
    type:
      - 'null'
      - int
    doc: Random number seed. If not provided system's default source of entropy will
      be used instead.
    inputBinding:
      position: 102
      prefix: --seed
  - id: sens
    type:
      - 'null'
      - int
    doc: Sensitivity of selected reads. If some positions are predominated by specific
      nucleotides, increasing this value can make simulated reads more similar to
      input reads. However runtime will also increase linearly.
    inputBinding:
      position: 102
      prefix: --sens
  - id: set_qual
    type:
      - 'null'
      - boolean
    doc: Use given Quality score with parameter 'qual' for all simulated reads.
    inputBinding:
      position: 102
      prefix: --setQual
outputs:
  - id: bed
    type:
      - 'null'
      - File
    doc: File name in which the simulated reads will be saved in BED format
    outputBinding:
      glob: $(inputs.bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/boquila:0.6.1--hdfd78af_0
