cwlVersion: v1.2
class: CommandLineTool
baseCommand: ultraplex
label: ultraplex
doc: "Ultra-fast demultiplexing of fastq files.\n\nTool homepage: https://github.com/ulelab/ultraplex.git"
inputs:
  - id: adapter
    type:
      - 'null'
      - string
    doc: sequencing adapter to trim [DEFAULT Illumina AGATCGGAAGAGCACACGTCTGAA 
      p7]. Specify 'p3' or AGATCGGAAGAGCGGTTCAG to trim legacy p3 sequence
    inputBinding:
      position: 101
      prefix: --adapter
  - id: adapter2
    type:
      - 'null'
      - string
    doc: sequencing adaptor to trim for the reverse read
    inputBinding:
      position: 101
      prefix: --adapter2
  - id: barcodes
    type: File
    doc: barcodes for demultiplexing in csv format
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: dont_build_reference
    type:
      - 'null'
      - boolean
    doc: Skip the reference building step - for long barcodes this will improve 
      speed.
    inputBinding:
      position: 101
      prefix: --dont_build_reference
  - id: final_min_length
    type:
      - 'null'
      - int
    doc: minimum length of the final outputted reads
    inputBinding:
      position: 101
      prefix: --final_min_length
  - id: five_prime_mismatches
    type:
      - 'null'
      - int
    doc: number of mismatches allowed for 5prime barcode
    inputBinding:
      position: 101
      prefix: --fiveprimemismatches
  - id: ignore_no_match
    type:
      - 'null'
      - boolean
    doc: Do not write reads for which there is no match.
    inputBinding:
      position: 101
      prefix: --ignore_no_match
  - id: ignore_space_warning
    type:
      - 'null'
      - boolean
    doc: whether to ignore warnings that there is not enough free space
    inputBinding:
      position: 101
      prefix: --ignore_space_warning
  - id: input_2
    type:
      - 'null'
      - File
    doc: Optional second fastq.gz input for paired end data
    inputBinding:
      position: 101
      prefix: --input_2
  - id: input_fastq
    type: File
    doc: fastq file to be demultiplexed
    inputBinding:
      position: 101
      prefix: --inputfastq
  - id: keep_barcode
    type:
      - 'null'
      - boolean
    doc: Do not remove barcodes/UMIs from the read (UMIs will still be moved to 
      the read header)
    inputBinding:
      position: 101
      prefix: --keep_barcode
  - id: min_trim
    type:
      - 'null'
      - int
    doc: When using single end reads for 3' demultiplexing, this is the minimum 
      adapter trimming amount for a 3'barcode to be detected. Default = 3
    inputBinding:
      position: 101
      prefix: --min_trim
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: optional output directory
    inputBinding:
      position: 101
      prefix: --directory
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix for output sequences
    inputBinding:
      position: 101
      prefix: --outputprefix
  - id: phred_quality
    type:
      - 'null'
      - int
    doc: phred quality score for 3prime end trimming
    inputBinding:
      position: 101
      prefix: --phredquality
  - id: phred_quality_5_prime
    type:
      - 'null'
      - int
    doc: quality trimming minimum score from 5' end - use with caution!
    inputBinding:
      position: 101
      prefix: --phredquality_5_prime
  - id: sbatch_compression
    type:
      - 'null'
      - boolean
    doc: whether to compress output fastq using SLURM sbatch
    inputBinding:
      position: 101
      prefix: --sbatchcompression
  - id: threads
    type:
      - 'null'
      - int
    doc: threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: three_prime_mismatches
    type:
      - 'null'
      - int
    doc: number of mismatches allowed for 3prime barcode
    inputBinding:
      position: 101
      prefix: --threeprimemismatches
  - id: three_prime_only
    type:
      - 'null'
      - boolean
    doc: Use this if only using 3 prime barcodes
    inputBinding:
      position: 101
      prefix: --three_prime_only
  - id: tso_seq
    type:
      - 'null'
      - string
    doc: Specify this if the read 1 has a TSO. Should be of format NNNNIII or 
      NNNNII where the N bases are moved to the UMI and the I bases are ignored
    inputBinding:
      position: 101
      prefix: --tso_seq
  - id: ultra
    type:
      - 'null'
      - boolean
    doc: whether to use ultra mode, which is faster but makes very large 
      temporary files
    inputBinding:
      position: 101
      prefix: --ultra
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ultraplex:1.2.10--py39hbcbf7aa_0
stdout: ultraplex.out
