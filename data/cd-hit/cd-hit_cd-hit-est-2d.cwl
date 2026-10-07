cwlVersion: v1.2
class: CommandLineTool
baseCommand: cd-hit-est-2d
label: cd-hit_cd-hit-est-2d
doc: 'CD-HIT: a fast program for clustering and comparing large sets of protein or
  nucleotide sequences (nucleotide version for comparing two datasets)'
inputs:
  - id: input_db1
    type: File
    doc: input filename for db1 in fasta format, required, can be in .gz format
    inputBinding:
      position: 101
      prefix: -i
  - id: input_db2
    type: File
    doc: input filename for db2 in fasta format, required, can be in .gz format
    inputBinding:
      position: 101
      prefix: -i2
  - id: input_r2_db1
    type:
      - 'null'
      - File
    doc: input filename in fasta/fastq format for db1 R2 reads if input are 
      paired end (PE) files
    inputBinding:
      position: 101
      prefix: -j
  - id: input_r2_db2
    type:
      - 'null'
      - File
    doc: input filename in fasta/fastq format for db2 R2 reads if input are 
      paired end (PE) files
    inputBinding:
      position: 101
      prefix: -j2
  - id: output
    type: string
    doc: output filename, required
    inputBinding:
      position: 101
      prefix: -o
  - id: output_r2
    type:
      - 'null'
      - string
    doc: output filename for R2 reads if input are paired end (PE) files
    inputBinding:
      position: 101
      prefix: -op
  - id: similarity_threshold
    type:
      - 'null'
      - float
    doc: sequence identity threshold, default 0.9
    inputBinding:
      position: 101
      prefix: -c
  - id: global_identity
    type:
      - 'null'
      - int
    doc: use global sequence identity, default 1; if set to 0, use local 
      sequence identity
    inputBinding:
      position: 101
      prefix: -G
  - id: band_width
    type:
      - 'null'
      - int
    doc: band_width of alignment, default 20
    inputBinding:
      position: 101
      prefix: -b
  - id: memory_limit
    type:
      - 'null'
      - int
    doc: memory limit (in MB) for the program, default 800; 0 for unlimitted
    inputBinding:
      position: 101
      prefix: -M
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads, default 1; with 0, all CPUs will be used
    inputBinding:
      position: 101
      prefix: -T
  - id: word_length
    type:
      - 'null'
      - int
    doc: word_length, default 10, see user's guide for choosing it
    inputBinding:
      position: 101
      prefix: -n
  - id: length_throw_away
    type:
      - 'null'
      - int
    doc: length of throw_away_sequences, default 10
    inputBinding:
      position: 101
      prefix: -l
  - id: description_length
    type:
      - 'null'
      - int
    doc: length of description in .clstr file, default 20; if set to 0, it takes
      the fasta defline and stops at first space
    inputBinding:
      position: 101
      prefix: -d
  - id: length_difference_cutoff
    type:
      - 'null'
      - float
    doc: length difference cutoff, default 0.0
    inputBinding:
      position: 101
      prefix: -s
  - id: length_difference_cutoff_aa
    type:
      - 'null'
      - int
    doc: length difference cutoff in amino acid, default 999999
    inputBinding:
      position: 101
      prefix: -S
  - id: length_difference_cutoff_db1
    type:
      - 'null'
      - float
    doc: length difference cutoff for db1, default 1.0
    inputBinding:
      position: 101
      prefix: -s2
  - id: length_difference_cutoff_db2_aa
    type:
      - 'null'
      - int
    doc: length difference cutoff, default 0
    inputBinding:
      position: 101
      prefix: -S2
  - id: coverage_longer_seq
    type:
      - 'null'
      - float
    doc: alignment coverage for the longer sequence, default 0.0
    inputBinding:
      position: 101
      prefix: -aL
  - id: coverage_control_longer_seq
    type:
      - 'null'
      - int
    doc: alignment coverage control for the longer sequence, default 99999999
    inputBinding:
      position: 101
      prefix: -AL
  - id: coverage_shorter_seq
    type:
      - 'null'
      - float
    doc: alignment coverage for the shorter sequence, default 0.0
    inputBinding:
      position: 101
      prefix: -aS
  - id: coverage_control_shorter_seq
    type:
      - 'null'
      - int
    doc: alignment coverage control for the shorter sequence, default 99999999
    inputBinding:
      position: 101
      prefix: -AS
  - id: min_coverage_both
    type:
      - 'null'
      - int
    doc: minimal alignment coverage control for the both sequences, default 0
    inputBinding:
      position: 101
      prefix: -A
  - id: max_unmatched_longer
    type:
      - 'null'
      - float
    doc: maximum unmatched percentage for the longer sequence, default 1.0
    inputBinding:
      position: 101
      prefix: -uL
  - id: max_unmatched_shorter
    type:
      - 'null'
      - float
    doc: maximum unmatched percentage for the shorter sequence, default 1.0
    inputBinding:
      position: 101
      prefix: -uS
  - id: max_unmatched_length
    type:
      - 'null'
      - int
    doc: maximum unmatched length, default 99999999
    inputBinding:
      position: 101
      prefix: -U
  - id: store_in_ram
    type:
      - 'null'
      - int
    doc: 1 or 0, default 0, by default, sequences are stored in RAM; if set to 
      1, sequence are stored on hard drive !! No longer supported !!
    inputBinding:
      position: 101
      prefix: -B
  - id: paired_end
    type:
      - 'null'
      - int
    doc: input paired end (PE) reads, default 0, single file; if set to 1, 
      please use -i R1 -j R2 to input both PE files
    inputBinding:
      position: 101
      prefix: -P
  - id: trim_length
    type:
      - 'null'
      - int
    doc: length to keep after trimming the tail of sequence, default 0, not 
      trimming
    inputBinding:
      position: 101
      prefix: -cx
  - id: trim_length_r2
    type:
      - 'null'
      - int
    doc: length to keep after trimming the tail of R2 sequence, default 0, not 
      trimming
    inputBinding:
      position: 101
      prefix: -cy
  - id: print_alignment_overlap
    type:
      - 'null'
      - int
    doc: 1 or 0, default 0; if set to 1, print alignment overlap in .clstr file
    inputBinding:
      position: 101
      prefix: -p
  - id: cluster_mode
    type:
      - 'null'
      - int
    doc: 1 or 0, default 0; if set to 1, cluster into the most similar cluster 
      that meets threshold (accurate but slow mode)
    inputBinding:
      position: 101
      prefix: -g
  - id: both_strands
    type:
      - 'null'
      - int
    doc: 1 or 0, default 1, by default do both +/+ & +/- alignments; if set to 
      0, only +/+ strand alignment
    inputBinding:
      position: 101
      prefix: -r
  - id: mask_letters
    type:
      - 'null'
      - string
    doc: masking letters (e.g. -mask NX, to mask out both 'N' and 'X')
    inputBinding:
      position: 101
      prefix: -mask
  - id: match_score
    type:
      - 'null'
      - int
    doc: matching score, default 2 (1 for T-U and N-N)
    inputBinding:
      position: 101
      prefix: -match
  - id: mismatch_score
    type:
      - 'null'
      - int
    doc: mismatching score, default -2
    inputBinding:
      position: 101
      prefix: -mismatch
  - id: gap_score
    type:
      - 'null'
      - int
    doc: gap opening score, default -6
    inputBinding:
      position: 101
      prefix: -gap
  - id: gap_ext_score
    type:
      - 'null'
      - int
    doc: gap extension score, default -1
    inputBinding:
      position: 101
      prefix: -gap-ext
  - id: backup_cluster_file
    type:
      - 'null'
      - int
    doc: write backup cluster file (1 or 0, default 0)
    inputBinding:
      position: 101
      prefix: -bak
outputs:
  - id: output_output
    type: File
    doc: output filename, required
    outputBinding:
      glob: $(inputs.output)
  - id: output_clusters
    type: File
    doc: Cluster file (.clstr) listing the db2 sequences clustered to db1
    outputBinding:
      glob: $(inputs.output).clstr
  - id: output_output_r2
    type:
      - 'null'
      - File
    doc: output filename for R2 reads if input are paired end (PE) files
    outputBinding:
      glob: $(inputs.output_r2)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
s:url: https://github.com/weizhongli/cdhit
$namespaces:
  s: https://schema.org/
