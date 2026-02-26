cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkv_complete_genomes
label: checkv_complete_genomes
doc: "Identify complete genomes based on terminal repeats and flanking host regions\n\
  \nTool homepage: https://bitbucket.org/berkeleylab/checkv"
inputs:
  - id: input
    type: File
    doc: Input nucleotide sequences in FASTA format (.gz, .bz2 and .xz files are
      supported)
    inputBinding:
      position: 1
  - id: kmer_max_freq
    type:
      - 'null'
      - float
    doc: Max kmer frequency (1.5). Computed by splitting genome into kmers, 
      counting occurence of each kmer, and taking the average count. Expected 
      value of 1.0 for no duplicated regions; 2.0 for the same genome repeated 
      back-to-back
    default: 1.5
    inputBinding:
      position: 102
      prefix: --kmer_max_freq
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress logging messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: tr_max_ambig
    type:
      - 'null'
      - float
    doc: Max fraction of TR composed of Ns
    default: 0.2
    inputBinding:
      position: 102
      prefix: --tr_max_ambig
  - id: tr_max_basefreq
    type:
      - 'null'
      - float
    doc: Max fraction of TR composed of single nucleotide
    default: 0.75
    inputBinding:
      position: 102
      prefix: --tr_max_basefreq
  - id: tr_max_count
    type:
      - 'null'
      - int
    doc: Max occurences of TR per contig
    default: 8
    inputBinding:
      position: 102
      prefix: --tr_max_count
  - id: tr_min_len
    type:
      - 'null'
      - int
    doc: Min length of TR
    default: 20
    inputBinding:
      position: 102
      prefix: --tr_min_len
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
