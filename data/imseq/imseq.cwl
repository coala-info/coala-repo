cwlVersion: v1.2
class: CommandLineTool
baseCommand: imseq
label: imseq
doc: "imseq is a tool for the analysis of T- and B-cell receptor chain\n    sequences.
  It can be used to analyse either single-read data, where the\n    reads cover the
  V-CDR3-J region sufficiently for an identification, or\n    paired-end data where
  one read covers the V-region and one read covers the\n    J- and CDR3-region. The
  latter read has do cover only a small fraction of\n    the V-segment, sufficient
  for the localization of the Cys-104 motif.\n\nTool homepage: http://www.imtools.org/"
inputs:
  - id: v_reads
    type: File
    doc: V reads
    inputBinding:
      position: 1
  - id: vdj_reads
    type: File
    doc: VDJ reads
    inputBinding:
      position: 2
  - id: vdj_reads_paired
    type: File
    doc: VDJ reads
    inputBinding:
      position: 3
  - id: barcode_err_rate
    type:
      - 'null'
      - float
    doc: "Maximum error rate between reads in order to be merged based on\n      \
      \    barcode sequence In range [0..1]."
    inputBinding:
      position: 104
      prefix: --barcode-err-rate
  - id: barcode_freq_rate
    type:
      - 'null'
      - float
    doc: "Inclusive maximum frequency ratio between smaller and larger cluster\n \
      \         during barcode clustering In range [0..1]."
    inputBinding:
      position: 104
      prefix: --barcode-freq-rate
  - id: barcode_length
    type:
      - 'null'
      - int
    doc: "Length of random barcode at the beginning of the read. A value of\n    \
      \      '0' disables barcode based correction. In range [0..inf]."
    inputBinding:
      position: 104
      prefix: --barcode-length
  - id: barcode_vdj
    type:
      - 'null'
      - boolean
    doc: "In paired end mode: Read the barcode from the VDJ read instead of\n    \
      \      the V read."
    inputBinding:
      position: 104
      prefix: --barcode-vdj
  - id: bc_min_qual
    type:
      - 'null'
      - int
    doc: "Minimum per base quality in molecular barcode region In range\n        \
      \  [0..60]."
    inputBinding:
      position: 104
      prefix: --bc-min-qual
  - id: bcseq_max_err
    type:
      - 'null'
      - int
    doc: "Maximum number of errors allowed in the barcode sequence In range\n    \
      \      [0..inf]."
    inputBinding:
      position: 104
      prefix: --bcseq-max-err
  - id: j_core_errors
    type:
      - 'null'
      - int
    doc: "Maximum number of errors when matching the J core fragments. In\n      \
      \    range [0..inf]."
    inputBinding:
      position: 104
      prefix: --j-core-errors
  - id: j_core_length
    type:
      - 'null'
      - int
    doc: Length of the J core fragment. In range [5..20].
    inputBinding:
      position: 104
      prefix: --j-core-length
  - id: j_core_offset
    type:
      - 'null'
      - int
    doc: Offset of the V core fragment.
    inputBinding:
      position: 104
      prefix: --j-core-offset
  - id: j_err_rate
    type:
      - 'null'
      - float
    doc: "Maximum error rate allowed within the J segment alignment In range\n   \
      \       [0..inf]."
    inputBinding:
      position: 104
      prefix: --j-err-rate
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of parallel jobs (threads).
    inputBinding:
      position: 104
      prefix: --jobs
  - id: max_clust_ratio
    type:
      - 'null'
      - float
    doc: "Maximum abundance ratio for two clonotypes to be clustered In range\n  \
      \        [0..1]."
    inputBinding:
      position: 104
      prefix: --max-clust-ratio
  - id: max_err_hq
    type:
      - 'null'
      - int
    doc: "Maximum edit-distance for two clusters to be clustered without low\n   \
      \       quality correlation In range [0..inf]."
    inputBinding:
      position: 104
      prefix: --max-err-hq
  - id: max_err_lq
    type:
      - 'null'
      - int
    doc: "Maximum edit-distance for two clusters to be potentially clustered\n   \
      \       without low quality correlation In range [0..inf]."
    inputBinding:
      position: 104
      prefix: --max-err-lq
  - id: merge_ambiguous_seg
    type:
      - 'null'
      - boolean
    doc: "Merge clonotypes with identical CDR3 sequences separated by\n          ambiguous
      segment identification"
    inputBinding:
      position: 104
      prefix: --merge-ambiguous-seg
  - id: min_cdr3_length
    type:
      - 'null'
      - int
    doc: Minimum CDR3 length in amino acids. In range [0..inf].
    inputBinding:
      position: 104
      prefix: --min-cdr3-length
  - id: min_clust_qual
    type:
      - 'null'
      - int
    doc: Minimum average cluster phred score. In range [0..60].
    inputBinding:
      position: 104
      prefix: --min-clust-qual
  - id: min_qual
    type:
      - 'null'
      - int
    doc: "Minimum average read phred score. In paired end mode, this is\n        \
      \  applied to both reads. See '-sfb'. In range [0..60]."
    inputBinding:
      position: 104
      prefix: --min-qual
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: "Minimum read length. In paired end mode, this is applied to both\n     \
      \     reads. See '-sfb'. In range [0..inf]."
    inputBinding:
      position: 104
      prefix: --min-read-length
  - id: min_sd_diff
    type:
      - 'null'
      - int
    doc: "How many standard deviations must an error positions quality value\n   \
      \       be below the mean to be considered for clustering."
    inputBinding:
      position: 104
      prefix: --min-sd-diff
  - id: paired_v_error
    type:
      - 'null'
      - float
    doc: "Maximum error rate in the alignment between the forward-read\n         \
      \ identified V segment and the reverse read. Default: Use value from\n     \
      \     -ev. In range [0..1]."
    inputBinding:
      position: 104
      prefix: --paired-v-error
  - id: print_alignments
    type:
      - 'null'
      - boolean
    doc: Print the V/J alignments for each read. Implies -j 1.
    inputBinding:
      position: 104
      prefix: --print-alignments
  - id: qual_clust
    type:
      - 'null'
      - boolean
    doc: Enable quality score based clustering.
    inputBinding:
      position: 104
      prefix: --qual-clust
  - id: reference
    type: File
    doc: FASTA file with gene segment reference sequences.
    inputBinding:
      position: 104
      prefix: --reference
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: "By default, V-reads are read as they are and V(D)J-reads are reverse\n \
      \         complemented. Use this switch for the opposite behaviour."
    inputBinding:
      position: 104
      prefix: --reverse
  - id: simple_clust
    type:
      - 'null'
      - boolean
    doc: Enable simple distance-based clustering
    inputBinding:
      position: 104
      prefix: --simple-clust
  - id: single_end_fallback
    type:
      - 'null'
      - boolean
    doc: "Fall back to single end analysis based on VDJ read if V read fails\n   \
      \       -mq or -mrl."
    inputBinding:
      position: 104
      prefix: --single-end-fallback
  - id: truncate_reads
    type:
      - 'null'
      - int
    doc: "Truncate reads to the specified length. 0 leaves them at their\n       \
      \   original lengths."
    inputBinding:
      position: 104
      prefix: --truncate-reads
  - id: v_core_errors
    type:
      - 'null'
      - int
    doc: "Maximum number of errors when matching the V core fragments. In\n      \
      \    range [0..inf]."
    inputBinding:
      position: 104
      prefix: --v-core-errors
  - id: v_core_length
    type:
      - 'null'
      - int
    doc: "Length of the V core fragment. Default: Automatically select value\n   \
      \       between 10 and 20 based on minimum observed read length. In range\n\
      \          [5..inf]."
    inputBinding:
      position: 104
      prefix: --v-core-length
  - id: v_core_offset
    type:
      - 'null'
      - int
    doc: Offset of the V core fragment.
    inputBinding:
      position: 104
      prefix: --v-core-offset
  - id: v_err_rate
    type:
      - 'null'
      - float
    doc: "Maximum error rate allowed within the V segment alignment In range\n   \
      \       [0..inf]."
    inputBinding:
      position: 104
      prefix: --v-err-rate
  - id: v_read_crop
    type:
      - 'null'
      - int
    doc: "Crop NUM bases from the beginning of the V read before processing it\n \
      \         In range [0..inf]."
    inputBinding:
      position: 104
      prefix: --v-read-crop
  - id: with_alleles
    type:
      - 'null'
      - boolean
    doc: Keep allele information in detailed output file specified with -o.
    inputBinding:
      position: 104
      prefix: --with-alleles
outputs:
  - id: out_amino
    type:
      - 'null'
      - File
    doc: Output file path for translated clonotypes.
    outputBinding:
      glob: $(inputs.out_amino)
  - id: out_nuc
    type:
      - 'null'
      - File
    doc: Output file path for untranslated clonotypes.
    outputBinding:
      glob: $(inputs.out_nuc)
  - id: out
    type:
      - 'null'
      - File
    doc: Output file path for verbose output per analyzed read.
    outputBinding:
      glob: $(inputs.out)
  - id: reject_log
    type:
      - 'null'
      - File
    doc: Log file for rejected reads. If empty, no log file is written.
    outputBinding:
      glob: $(inputs.reject_log)
  - id: barcode_stats
    type:
      - 'null'
      - File
    doc: "Path to barcode stats output file. If empty, no file is written.\n     \
      \     Ignored if -bcl is 0."
    outputBinding:
      glob: $(inputs.barcode_stats)
  - id: out_amino_bc
    type:
      - 'null'
      - File
    doc: "Output file path for translated clonotypes with barcode corrected\n    \
      \      counts. Ignored if -bcl is 0."
    outputBinding:
      glob: $(inputs.out_amino_bc)
  - id: out_nuc_bc
    type:
      - 'null'
      - File
    doc: "Output file path for untranslated clonotypes with barcode corrected\n  \
      \        counts. Ignored if -bcl is 0."
    outputBinding:
      glob: $(inputs.out_nuc_bc)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imseq:1.1.0--h077b44d_8
