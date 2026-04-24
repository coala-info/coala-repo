cwlVersion: v1.2
class: CommandLineTool
baseCommand: tiptoft
label: tiptoft
doc: "Plasmid replicon and incompatibility group prediction from uncorrected long
  reads\n\nTool homepage: https://github.com/andrewjpage/tiptoft"
inputs:
  - id: input_fastq
    type: File
    doc: Input FASTQ file (optionally gzipped)
    inputBinding:
      position: 1
  - id: kmer
    type:
      - 'null'
      - int
    doc: k-mer size
    inputBinding:
      position: 102
      prefix: --kmer
  - id: margin
    type:
      - 'null'
      - int
    doc: Flanking region around a block to use for mapping
    inputBinding:
      position: 102
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap for blocks to be contigous, measured in multiples of the 
      k-mer size
    inputBinding:
      position: 102
  - id: max_kmer_count
    type:
      - 'null'
      - int
    doc: Exclude k-mers which occur more than this number of times in a sequence
    inputBinding:
      position: 102
  - id: min_block_size
    type:
      - 'null'
      - int
    doc: Minimum block size in bases
    inputBinding:
      position: 102
  - id: min_fasta_hits
    type:
      - 'null'
      - int
    doc: Minimum No. of kmers matching a read
    inputBinding:
      position: 102
      prefix: --min_fasta_hits
  - id: min_kmers_for_onex_pass
    type:
      - 'null'
      - int
    doc: Minimum No. of kmers matching a read in 1st pass
    inputBinding:
      position: 102
  - id: min_perc_coverage
    type:
      - 'null'
      - float
    doc: Minimum percentage coverage of typing sequence to report
    inputBinding:
      position: 102
      prefix: --min_perc_coverage
  - id: no_gene_filter
    type:
      - 'null'
      - boolean
    doc: Dont filter out lower coverage genes from same group
    inputBinding:
      position: 102
  - id: no_hc_compression
    type:
      - 'null'
      - boolean
    doc: Turn off homoploymer compression of k-mers
    inputBinding:
      position: 102
  - id: plasmid_data
    type:
      - 'null'
      - File
    doc: FASTA file containing plasmid data from downloader script, defaults to 
      bundled database
    inputBinding:
      position: 102
      prefix: --plasmid_data
  - id: print_interval
    type:
      - 'null'
      - int
    doc: Print results every this number of reads
    inputBinding:
      position: 102
      prefix: --print_interval
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on debugging
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: filtered_reads_file
    type:
      - 'null'
      - File
    doc: Filename to save matching reads to
    outputBinding:
      glob: $(inputs.filtered_reads_file)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file [STDOUT]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiptoft:1.0.2--py310h4b81fae_4
