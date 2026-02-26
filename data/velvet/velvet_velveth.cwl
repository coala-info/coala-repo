cwlVersion: v1.2
class: CommandLineTool
baseCommand: velveth
label: velvet_velveth
doc: "simple hashing program\n\nTool homepage: https://github.com/dzerbino/velvet"
inputs:
  - id: directory
    type: Directory
    doc: directory name for output files
    inputBinding:
      position: 1
  - id: hash_length
    type: string
    doc: 'EITHER an odd integer (if even, it will be decremented) <= 191 (if above,
      will be reduced) OR: m,M,s where m and M are odd integers (if not, they will
      be decremented) with m < M <= 191 (if above, will be reduced) and s is a step
      (even number). Velvet will then hash from k=m to k=M with a step of s'
    inputBinding:
      position: 2
  - id: filenames
    type:
      - 'null'
      - type: array
        items: File
    doc: path to sequence file or - for standard input
    inputBinding:
      position: 3
  - id: bam
    type:
      - 'null'
      - boolean
    doc: Use BAM file format
    inputBinding:
      position: 104
      prefix: -bam
  - id: create_binary
    type:
      - 'null'
      - boolean
    doc: 'create binary CnyUnifiedSeq file (default: off)'
    inputBinding:
      position: 104
      prefix: -create_binary
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Use FASTA file format
    inputBinding:
      position: 104
      prefix: -fasta
  - id: fasta_gz
    type:
      - 'null'
      - boolean
    doc: Use gzipped FASTA file format
    inputBinding:
      position: 104
      prefix: -fasta.gz
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Use FASTQ file format
    inputBinding:
      position: 104
      prefix: -fastq
  - id: fastq_gz
    type:
      - 'null'
      - boolean
    doc: Use gzipped FASTQ file format
    inputBinding:
      position: 104
      prefix: -fastq.gz
  - id: file_format
    type:
      - 'null'
      - string
    doc: File format option
    inputBinding:
      position: 104
  - id: file_layout
    type:
      - 'null'
      - string
    doc: File layout option for paired reads
    inputBinding:
      position: 104
  - id: fmt_auto
    type:
      - 'null'
      - boolean
    doc: Auto-detect FASTA or FASTQ file format
    inputBinding:
      position: 104
      prefix: -fmtAuto
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Paired reads are interleaved in one file
    inputBinding:
      position: 104
      prefix: -interleaved
  - id: long
    type:
      - 'null'
      - boolean
    doc: Long single-end reads
    inputBinding:
      position: 104
      prefix: -long
  - id: long_paired
    type:
      - 'null'
      - boolean
    doc: Long paired-end reads
    inputBinding:
      position: 104
      prefix: -longPaired
  - id: no_hash
    type:
      - 'null'
      - boolean
    doc: 'simply prepare Sequences file, do not hash reads or prepare Roadmaps file
      (default: off)'
    inputBinding:
      position: 104
      prefix: -noHash
  - id: raw
    type:
      - 'null'
      - boolean
    doc: Use RAW file format
    inputBinding:
      position: 104
      prefix: -raw
  - id: raw_gz
    type:
      - 'null'
      - boolean
    doc: Use gzipped RAW file format
    inputBinding:
      position: 104
      prefix: -raw.gz
  - id: read_type
    type:
      - 'null'
      - string
    doc: Read type option
    inputBinding:
      position: 104
  - id: reference
    type:
      - 'null'
      - boolean
    doc: Reference sequence
    inputBinding:
      position: 104
      prefix: -reference
  - id: reuse_binary
    type:
      - 'null'
      - boolean
    doc: 'reuse binary sequences file (or link) already in directory (no need to provide
      original filenames in this case (default: off)'
    inputBinding:
      position: 104
      prefix: -reuse_binary
  - id: reuse_sequences
    type:
      - 'null'
      - boolean
    doc: 'reuse Sequences file (or link) already in directory (no need to provide
      original filenames in this case (default: off)'
    inputBinding:
      position: 104
      prefix: -reuse_Sequences
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Use SAM file format
    inputBinding:
      position: 104
      prefix: -sam
  - id: separate
    type:
      - 'null'
      - boolean
    doc: Paired reads are in separate files
    inputBinding:
      position: 104
      prefix: -separate
  - id: short
    type:
      - 'null'
      - boolean
    doc: Short single-end reads
    inputBinding:
      position: 104
      prefix: -short
  - id: short2
    type:
      - 'null'
      - boolean
    doc: Short single-end reads (channel 2)
    inputBinding:
      position: 104
      prefix: -short2
  - id: short3
    type:
      - 'null'
      - boolean
    doc: Short single-end reads (channel 3)
    inputBinding:
      position: 104
      prefix: -short3
  - id: short4
    type:
      - 'null'
      - boolean
    doc: Short single-end reads (channel 4)
    inputBinding:
      position: 104
      prefix: -short4
  - id: short_paired
    type:
      - 'null'
      - boolean
    doc: Short paired-end reads
    inputBinding:
      position: 104
      prefix: -shortPaired
  - id: short_paired2
    type:
      - 'null'
      - boolean
    doc: Short paired-end reads (channel 2)
    inputBinding:
      position: 104
      prefix: -shortPaired2
  - id: short_paired3
    type:
      - 'null'
      - boolean
    doc: Short paired-end reads (channel 3)
    inputBinding:
      position: 104
      prefix: -shortPaired3
  - id: short_paired4
    type:
      - 'null'
      - boolean
    doc: Short paired-end reads (channel 4)
    inputBinding:
      position: 104
      prefix: -shortPaired4
  - id: strand_specific
    type:
      - 'null'
      - boolean
    doc: 'for strand specific transcriptome sequencing data (default: off)'
    inputBinding:
      position: 104
      prefix: -strand_specific
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/velvet:1.2.10--h577a1d6_9
stdout: velvet_velveth.out
