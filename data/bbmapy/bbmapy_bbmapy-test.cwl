cwlVersion: v1.2
class: CommandLineTool
baseCommand: bbmapy-test
label: bbmapy_bbmapy-test
doc: "BBMapy test suite, demonstrating various BBMap tools.\n\nTool homepage: https://github.com/urineri/bbmapy"
inputs:
  - id: branch_lower
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: branchlower
  - id: branch_mult1
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: branchmult1
  - id: branch_mult2
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: branchmult2
  - id: build
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: build
  - id: ecc_pincer
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: eccpincer
  - id: ecc_reassemble
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: eccreassemble
  - id: ecc_tail
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: ecctail
  - id: extend2_len
    type:
      - 'null'
      - int
    doc: Extension length for read 2.
    inputBinding:
      position: 101
      prefix: extend2
  - id: fasta_read_len
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: fastareadlen
  - id: in1_fastq
    type:
      - 'null'
      - File
    doc: Input file for read 1.
    inputBinding:
      position: 101
      prefix: in1
  - id: in2_fastq
    type:
      - 'null'
      - File
    doc: Input file for read 2.
    inputBinding:
      position: 101
      prefix: in2
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size for merging.
    inputBinding:
      position: 101
      prefix: k
  - id: min_count_extend
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: mincountextend
  - id: min_count_seed
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: mincountseed
  - id: min_prob
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: minprob
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Number of reads to generate.
    inputBinding:
      position: 101
      prefix: reads
  - id: overwrite
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: overwrite
  - id: paired_reads
    type:
      - 'null'
      - boolean
    doc: Generate paired-end reads.
    inputBinding:
      position: 101
      prefix: paired
  - id: prefilter_tadpole
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: prefilter
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA file for read generation.
    inputBinding:
      position: 101
      prefix: ref
  - id: ref_len
    type:
      - 'null'
      - int
    doc: Length of the reference genome to generate.
    inputBinding:
      position: 101
      prefix: len
  - id: remove_unmerged
    type:
      - 'null'
      - boolean
    doc: Remove unmerged reads.
    inputBinding:
      position: 101
      prefix: rem
  - id: strict_merge
    type:
      - 'null'
      - boolean
    doc: Enforce strict merging criteria.
    inputBinding:
      position: 101
      prefix: strict
  - id: threads
    type:
      - 'null'
      - string
    doc: Maximum Java heap size.
    inputBinding:
      position: 101
      prefix: -Xmx
outputs:
  - id: out_ref
    type:
      - 'null'
      - File
    doc: Output file for the reference genome.
    outputBinding:
      glob: $(inputs.out_ref)
  - id: out1_fastq
    type:
      - 'null'
      - File
    doc: Output file for the first read pair.
    outputBinding:
      glob: $(inputs.out1_fastq)
  - id: out2_fastq
    type:
      - 'null'
      - File
    doc: Output file for the second read pair.
    outputBinding:
      glob: $(inputs.out2_fastq)
  - id: out_single_fastq
    type:
      - 'null'
      - File
    doc: Output file for single-end reads.
    outputBinding:
      glob: $(inputs.out_single_fastq)
  - id: out_sam
    type:
      - 'null'
      - File
    doc: Output SAM file.
    outputBinding:
      glob: $(inputs.out_sam)
  - id: out_merged_fastq
    type:
      - 'null'
      - File
    doc: Output file for merged reads.
    outputBinding:
      glob: $(inputs.out_merged_fastq)
  - id: outu1_fastq
    type:
      - 'null'
      - File
    doc: Output file for unmerged reads (read 1).
    outputBinding:
      glob: $(inputs.outu1_fastq)
  - id: outu2_fastq
    type:
      - 'null'
      - File
    doc: Output file for unmerged reads (read 2).
    outputBinding:
      glob: $(inputs.outu2_fastq)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmapy:0.0.51--pyhdfd78af_0
