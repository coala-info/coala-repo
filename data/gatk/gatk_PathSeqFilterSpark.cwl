cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - PathSeqFilterSpark
label: gatk_PathSeqFilterSpark
doc: |-
  Filters low complexity, low quality, duplicate, and host reads. First step in the PathSeq pipeline.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --input
    inputBinding:
      position: 101
    doc: BAM/SAM/CRAM file containing reads This argument must be specified at least
      once.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
      - pattern: .sbi
        required: false
  - id: disable_sequence_dictionary_validation
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --disable-sequence-dictionary-validation
    doc: 'If specified, do not check the sequence dictionaries from our inputs for
      compatibility. Use at your own risk! Default value: false. Possible values:
      {true, false}'
  - id: dust_mask_quality
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --dust-mask-quality
    doc: 'Base quality to assign low-complexity bases Default value: 2.'
  - id: dust_t
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --dust-t
    doc: 'DUST algorithm score threshold Default value: 20.0.'
  - id: dust_window
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --dust-window
    doc: 'DUST algorithm window size Default value: 64.'
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals to exclude from processing This argument may
      be specified 0 or more times.
  - id: filter_bwa_image
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --filter-bwa-image
    doc: The BWA image file of the host reference. This must be distributed to local
      disk on each node.
  - id: filter_bwa_seed_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --filter-bwa-seed-length
    doc: 'Minimum seed length for the host BWA alignment. Default value: 19.'
  - id: filter_duplicates
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --filter-duplicates
      valueFrom: '$(self ? ''true'' : ''false'')'
    doc: 'Filter duplicate reads Default value: true. Possible values: {true, false}'
  - id: filter_metrics
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --filter-metrics
    doc: Log counts of filtered reads to this file
  - id: host_kmer_thresh
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --host-kmer-thresh
    doc: 'Host kmer count threshold. Default value: 1.'
  - id: host_min_identity
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --host-min-identity
    doc: 'Host alignment identity score threshold, in bp Default value: 30.'
  - id: ignore_alignment_contigs
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ignore-alignment-contigs
    inputBinding:
      position: 101
    doc: Host-aligned BAM contigs to ignore This argument may be specified 0 or more
      times.
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals over which to operate This argument may be
      specified 0 or more times.
  - id: is_host_aligned
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --is-host-aligned
    doc: 'Set if the input BAM is aligned to the host Default value: false. Possible
      values: {true, false}'
  - id: kmer_file
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --kmer-file
    doc: Path to host k-mer file generated with PathSeqBuildKmers. K-mer filtering
      is skipped if this is not specified.
  - id: max_adapter_mismatches
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-adapter-mismatches
    doc: 'Maximum number of mismatches for adapter trimming Default value: 1.'
  - id: max_masked_bases
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-masked-bases
    doc: 'Max allowable number of masked bases per read Default value: 2.'
  - id: min_adapter_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-adapter-length
    doc: 'Minimum length of adapter sequence to trim Default value: 12.'
  - id: min_base_quality
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-base-quality
    doc: 'Bases below this call quality will be masked with ''N'' Default value: 15.'
  - id: min_clipped_read_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-clipped-read-length
    doc: 'Minimum length of reads after quality trimming Default value: 31.'
  - id: paired_output
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --paired-output
    doc: Output BAM containing only paired reads
  - id: quality_threshold
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --quality-threshold
    doc: 'Quality score trimmer threshold Default value: 15.'
  - id: reference
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --reference
    doc: Reference sequence
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
      - pattern: .gzi
        required: false
      - pattern: ^^.dict
        required: false
  - id: skip_quality_filters
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --skip-quality-filters
    doc: 'Skip low-quality and low-complexity read filtering Default value: false.
      Possible values: {true, false}'
  - id: unpaired_output
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --unpaired-output
    doc: Output BAM containing only unpaired reads
  - id: filter_reads_per_partition
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --filter-reads-per-partition
    doc: 'Estimated reads per partition after quality, kmer, and BWA filtering Default
      value: 200000.'
  - id: skip_pre_bwa_repartition
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --skip-pre-bwa-repartition
    doc: 'Skip pre-BWA repartition. Set to true for inputs with a high proportion
      of microbial reads that are not host coordinate-sorted. Default value: false.
      Possible values: {true, false}'
outputs:
  - id: filter_metrics_out
    type:
      - 'null'
      - File
    doc: Log counts of filtered reads to this file
    outputBinding:
      glob: $(inputs.filter_metrics)
  - id: paired_output_out
    type:
      - 'null'
      - File
    doc: Output BAM containing only paired reads
    outputBinding:
      glob: $(inputs.paired_output)
  - id: unpaired_output_out
    type:
      - 'null'
      - File
    doc: Output BAM containing only unpaired reads
    outputBinding:
      glob: $(inputs.unpaired_output)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
