cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextPolish2
label: nextpolish2_nextPolish2
doc: "Repeat-aware polishing genomes assembled using HiFi long reads\n\nTool homepage:
  https://github.com/Nextomics/NextPolish2"
inputs:
  - id: hifi_map_bam
    type: File
    doc: HiFi-to-ref mapping file in sorted BAM format.
    inputBinding:
      position: 1
  - id: genome_fa
    type: File
    doc: genome assembly file in [GZIP] FASTA format.
    inputBinding:
      position: 2
  - id: short_read_yak
    type:
      type: array
      items: File
    doc: one or more k-mer dataset in yak format.
    inputBinding:
      position: 3
  - id: iter_count
    type:
      - 'null'
      - int
    doc: number of iterations to attempt phasing.
    inputBinding:
      position: 104
      prefix: --iter_count
  - id: max_clip_len
    type:
      - 'null'
      - int
    doc: filter alignments with unaligned length >= INT.
    inputBinding:
      position: 104
      prefix: --max_clip_len
  - id: max_indel_len
    type:
      - 'null'
      - int
    doc: ignore indel errors with length > INT.
    inputBinding:
      position: 104
      prefix: --max_indel_len
  - id: min_ctg_len
    type:
      - 'null'
      - int
    doc: don't correct reference sequences with length <= INT.
    inputBinding:
      position: 104
      prefix: --min_ctg_len
  - id: min_kmer_count
    type:
      - 'null'
      - int
    doc: filter kmers in k-mer dataset with count <= INT.
    inputBinding:
      position: 104
      prefix: --min_kmer_count
  - id: min_map_len
    type:
      - 'null'
      - float
    doc: filter alignments with alignment length <= min(INT, FLOAT * 
      read_length).
    inputBinding:
      position: 104
      prefix: --min_map_len
  - id: min_map_qual
    type:
      - 'null'
      - int
    doc: filter alignments with mapping quality <= INT.
    inputBinding:
      position: 104
      prefix: --min_map_qual
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: filter reads with length <= INT.
    inputBinding:
      position: 104
      prefix: --min_read_len
  - id: model
    type:
      - 'null'
      - string
    doc: "phasing model.\n\n          Possible values:\n          - ref: output the
      same haplotype phase blocks as the reference\n          - len: output longer
      haplotype phase blocks"
    inputBinding:
      position: 104
      prefix: --model
  - id: out_pos
    type:
      - 'null'
      - boolean
    doc: output each base and its position.
    inputBinding:
      position: 104
      prefix: --out_pos
  - id: thread
    type:
      - 'null'
      - int
    doc: number of threads.
    inputBinding:
      position: 104
      prefix: --thread
  - id: uppercase
    type:
      - 'null'
      - boolean
    doc: output in uppercase sequences.
    inputBinding:
      position: 104
      prefix: --uppercase
  - id: use_all_reads
    type:
      - 'null'
      - boolean
    doc: use all unfiltered reads, reads with different haplotypes from the 
      reference assembly are discarded by default.
    inputBinding:
      position: 104
      prefix: --use_all_reads
  - id: use_secondary
    type:
      - 'null'
      - boolean
    doc: use secondary alignments, consider setting `min_map_qual` to -1 when 
      using this option.
    inputBinding:
      position: 104
      prefix: --use_secondary
  - id: use_supplementary
    type:
      - 'null'
      - boolean
    doc: use supplementary alignments.
    inputBinding:
      position: 104
      prefix: --use_supplementary
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextpolish2:0.2.2--h74ec884_0
