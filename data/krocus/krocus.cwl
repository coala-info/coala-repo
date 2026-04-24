cwlVersion: v1.2
class: CommandLineTool
baseCommand: krocus
label: krocus
doc: "Multi-locus sequence typing (MLST) from uncorrected long reads. Please cite:\n\
  Andrew J. Page, Jacqueline A. Keane. (2018) Rapid multi-locus sequence typing\n\
  direct from uncorrected long reads using Krocus. PeerJ 6:e5233\nhttps://doi.org/10.7717/peerj.5233\n\
  \nTool homepage: https://github.com/andrewjpage/krocus"
inputs:
  - id: allele_directory
    type: Directory
    doc: Allele directory
    inputBinding:
      position: 1
  - id: input_fastq
    type: File
    doc: Input FASTQ file (optionally gzipped)
    inputBinding:
      position: 2
  - id: divisible_by_3
    type:
      - 'null'
      - boolean
    doc: Genes which are not divisible by 3 are excluded
    inputBinding:
      position: 103
      prefix: --divisible_by_3
  - id: filtered_reads_file
    type:
      - 'null'
      - File
    doc: Filename to save matching reads to
    inputBinding:
      position: 103
      prefix: --filtered_reads_file
  - id: kmer
    type:
      - 'null'
      - int
    doc: k-mer size
    inputBinding:
      position: 103
      prefix: --kmer
  - id: margin
    type:
      - 'null'
      - int
    doc: Flanking region around a block to use for mapping
    inputBinding:
      position: 103
      prefix: --margin
  - id: max_gap
    type:
      - 'null'
      - int
    doc: "Maximum gap for blocks to be contigous, measured in\nmultiples of the k-mer
      size"
    inputBinding:
      position: 103
      prefix: --max_gap
  - id: max_kmers
    type:
      - 'null'
      - int
    doc: Dont count kmers occuring more than this many times
    inputBinding:
      position: 103
      prefix: --max_kmers
  - id: min_block_size
    type:
      - 'null'
      - int
    doc: Minimum block size in bases
    inputBinding:
      position: 103
      prefix: --min_block_size
  - id: min_fasta_hits
    type:
      - 'null'
      - int
    doc: Minimum No. of kmers matching a read
    inputBinding:
      position: 103
      prefix: --min_fasta_hits
  - id: min_kmers_for_onex_pass
    type:
      - 'null'
      - int
    doc: Minimum No. of kmers matching a read in 1st pass
    inputBinding:
      position: 103
      prefix: --min_kmers_for_onex_pass
  - id: print_interval
    type:
      - 'null'
      - int
    doc: Print ST every this number of reads
    inputBinding:
      position: 103
      prefix: --print_interval
  - id: target_st
    type:
      - 'null'
      - string
    doc: For performance testing print time to find given ST
    inputBinding:
      position: 103
      prefix: --target_st
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on debugging
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krocus:1.0.3--pyhdfd78af_0
