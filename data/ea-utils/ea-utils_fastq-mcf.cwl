cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-mcf
label: ea-utils_fastq-mcf
doc: "Detects levels of adapter presence, computes likelihoods and locations (start,
  end) of the adapters. Removes the adapter sequences from the fastq file(s).\n\n\
  Tool homepage: https://expressionanalysis.github.io/ea-utils/"
inputs:
  - id: adapters_fa
    type: File
    doc: Adapter file in FASTA format
    inputBinding:
      position: 1
  - id: reads_fq
    type: File
    doc: FASTQ file containing reads
    inputBinding:
      position: 2
  - id: mates1_fq
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional FASTQ files for paired-end reads
    inputBinding:
      position: 3
  - id: bad_read_pct_removal
    type:
      - 'null'
      - int
    doc: "'N' (Bad read) percentage causing cycle removal"
    inputBinding:
      position: 104
      prefix: -x
  - id: cycle_adjust
    type:
      - 'null'
      - string
    doc: Adjust cycle CYC (negative = offset from end) by amount AMT
    inputBinding:
      position: 104
      prefix: --cycle-adjust
  - id: debug_output
    type:
      - 'null'
      - boolean
    doc: Output lots of random debugging stuff
    inputBinding:
      position: 104
      prefix: -d
  - id: disable_default_settings
    type:
      - 'null'
      - boolean
    doc: Set all default parameters to zero/do nothing
    inputBinding:
      position: 104
      prefix: '-0'
  - id: dont_clip
    type:
      - 'null'
      - boolean
    doc: Don't clip, just output what would be done
    inputBinding:
      position: 104
      prefix: -n
  - id: dont_remove_ns
    type:
      - 'null'
      - boolean
    doc: Don't remove N's from the fronts/ends of reads
    inputBinding:
      position: 104
      prefix: -R
  - id: force_disable_illumina_pf_filtering
    type:
      - 'null'
      - boolean
    doc: Force disable Illumina PF filtering
    inputBinding:
      position: 104
      prefix: -U
  - id: force_enable_illumina_pf_filtering
    type:
      - 'null'
      - boolean
    doc: Force enable Illumina PF filtering
    inputBinding:
      position: 104
      prefix: -u
  - id: homopolymer_pct
    type:
      - 'null'
      - float
    doc: Homopolymer filter percent
    inputBinding:
      position: 104
      prefix: --homopolymer-pct
  - id: keep_clipped
    type:
      - 'null'
      - boolean
    doc: Only keep clipped (same as -K)
    inputBinding:
      position: 104
      prefix: --keep-clipped
  - id: keep_clipped_reads
    type:
      - 'null'
      - boolean
    doc: Only keep clipped reads
    inputBinding:
      position: 104
      prefix: -K
  - id: log_scale_min_len_match
    type:
      - 'null'
      - float
    doc: Log scale for adapter minimum-length-match
    inputBinding:
      position: 104
      prefix: -s
  - id: lowcomplex_pct
    type:
      - 'null'
      - float
    doc: Complexity filter percent
    inputBinding:
      position: 104
      prefix: --lowcomplex-pct
  - id: mate_max_ns
    type:
      - 'null'
      - string
    doc: Maxmium N-calls in a mate read (can be a %)
    inputBinding:
      position: 104
      prefix: --mate-max-ns
  - id: mate_min_len
    type:
      - 'null'
      - int
    doc: Minimum remaining length for mate reads (same as -l)
    inputBinding:
      position: 104
      prefix: --mate-min-len
  - id: mate_min_mean_quality
    type:
      - 'null'
      - float
    doc: Minimum mean quality score for mate reads
    inputBinding:
      position: 104
      prefix: --mate-qual-mean
  - id: mate_min_quals_gt
    type:
      - 'null'
      - string
    doc: At least NUM quals > THR for mate reads
    inputBinding:
      position: 104
      prefix: --mate-qual-gt
  - id: max_adapter_diff_pct
    type:
      - 'null'
      - int
    doc: Maximum adapter difference percentage
    inputBinding:
      position: 104
      prefix: -p
  - id: max_ns
    type:
      - 'null'
      - string
    doc: Maxmium N-calls in a read (can be a %)
    inputBinding:
      position: 104
      prefix: --max-ns
  - id: max_output_reads
    type:
      - 'null'
      - int
    doc: Only output first N records (same as -O)
    inputBinding:
      position: 104
      prefix: --max-output-reads
  - id: max_remaining_length
    type:
      - 'null'
      - int
    doc: Maximum remaining sequence length
    inputBinding:
      position: 104
      prefix: -L
  - id: min_clip_length
    type:
      - 'null'
      - int
    doc: Minimum clip length, overrides scaled auto
    inputBinding:
      position: 104
      prefix: -m
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum remaining length (same as -l)
    inputBinding:
      position: 104
      prefix: --min-len
  - id: min_mean_quality
    type:
      - 'null'
      - float
    doc: Minimum mean quality score
    inputBinding:
      position: 104
      prefix: --qual-mean
  - id: min_quals_gt
    type:
      - 'null'
      - string
    doc: At least NUM quals > THR
    inputBinding:
      position: 104
      prefix: --qual-gt
  - id: min_remaining_length
    type:
      - 'null'
      - int
    doc: Minimum remaining sequence length
    inputBinding:
      position: 104
      prefix: -l
  - id: occurrence_threshold
    type:
      - 'null'
      - float
    doc: '% occurance threshold before adapter clipping'
    inputBinding:
      position: 104
      prefix: -t
  - id: output_first_n_records
    type:
      - 'null'
      - int
    doc: Only output the first N records
    inputBinding:
      position: 104
      prefix: -O
  - id: phred_adjust
    type:
      - 'null'
      - string
    doc: Adjust score SCORE by amount AMT
    inputBinding:
      position: 104
      prefix: --phred-adjust
  - id: phred_adjust_max
    type:
      - 'null'
      - int
    doc: Adjust scores > SCORE to SCOTE
    inputBinding:
      position: 104
      prefix: --phred-adjust-max
  - id: phred_scale
    type:
      - 'null'
      - int
    doc: Phred-scale
    inputBinding:
      position: 104
      prefix: -P
  - id: quality_threshold_base_removal
    type:
      - 'null'
      - int
    doc: quality threshold causing base removal
    inputBinding:
      position: 104
      prefix: -q
  - id: quality_trimming_window_size
    type:
      - 'null'
      - int
    doc: window-size for quality trimming
    inputBinding:
      position: 104
      prefix: -w
  - id: remove_duplicate_reads_bases
    type:
      - 'null'
      - int
    doc: 'Remove duplicate reads: Read_1 has an identical N bases'
    inputBinding:
      position: 104
      prefix: -D
  - id: remove_high_homopolymer_reads
    type:
      - 'null'
      - boolean
    doc: remove >95% homopolymer reads
    inputBinding:
      position: 104
      prefix: -H
  - id: remove_low_complexity_reads
    type:
      - 'null'
      - boolean
    doc: remove low complexity reads
    inputBinding:
      position: 104
      prefix: -X
  - id: save_discarded_reads
    type:
      - 'null'
      - boolean
    doc: Save all discarded reads to '.skip' files
    inputBinding:
      position: 104
      prefix: -S
  - id: skew_pct_removal
    type:
      - 'null'
      - int
    doc: sKew percentage-less-than causing cycle removal
    inputBinding:
      position: 104
      prefix: -k
  - id: subsampling_reads_count
    type:
      - 'null'
      - int
    doc: Number of reads to use for subsampling
    inputBinding:
      position: 104
      prefix: -C
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for stats (defaults to stderr, stdout if specified)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ea-utils:1.1.2.779--h9dd4a16_0
