cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - PathSeqPipelineSpark
label: gatk_PathSeqPipelineSpark
doc: |-
  Combined tool that performs all PathSeq steps: read filtering, microbe reference alignment and abundance scoring

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
  - id: microbe_bwa_image
    type: File
    inputBinding:
      position: 101
      prefix: --microbe-bwa-image
    doc: Microbe reference BWA index image file generated using BwaMemIndexImageCreator.
      If running on a Spark cluster, this must be distributed to local disk on each
      node.
  - id: microbe_dict
    type: File
    inputBinding:
      position: 101
      prefix: --microbe-dict
    doc: Use the given sequence dictionary as the microbe sequence dictionary. Must
      be a .dict file.
  - id: scores_output
    type: string
    inputBinding:
      position: 101
      prefix: --scores-output
    doc: URI for the taxonomic scores output
  - id: taxonomy_file
    type: File
    inputBinding:
      position: 101
      prefix: --taxonomy-file
    doc: URI to the microbe reference taxonomy database built using PathSeqBuildReferenceTaxonomy
  - id: bwa_score_threshold
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --bwa-score-threshold
    doc: 'Minimum score threshold for microbe alignments Default value: 30.'
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
  - id: divide_by_genome_length
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --divide-by-genome-length
    doc: 'Divide abundance scores by each taxon''s reference genome length (in millions)
      Default value: false. Possible values: {true, false}'
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
  - id: identity_margin
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --identity-margin
    doc: 'Identity margin, as a fraction of the best hit (between 0 and 1). Default
      value: 0.02.'
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
  - id: max_alternate_hits
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-alternate-hits
    doc: 'Maximum number of alternate microbe alignments Default value: 5000.'
  - id: max_masked_bases
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-masked-bases
    doc: 'Max allowable number of masked bases per read Default value: 2.'
  - id: microbe_min_seed_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --microbe-min-seed-length
    doc: 'Minimum BWA-MEM seed length for the microbe alignment Default value: 19.'
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
  - id: min_score_identity
    type:
      - 'null'
      - float
    inputBinding:
      position: 101
      prefix: --min-score-identity
    doc: 'Alignment identity score threshold, as a fraction of the read length (between
      0 and 1). Default value: 0.9.'
  - id: not_normalized_by_kingdom
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --not-normalized-by-kingdom
    doc: 'If true, normalized abundance scores will be reported as a percentage within
      their kingdom. Default value: false. Possible values: {true, false}'
  - id: output
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --output
    doc: Output BAM
  - id: pipeline_reads_per_partition
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --pipeline-reads-per-partition
    doc: 'Number of reads per partition to use for alignment and scoring. Default
      value: 5000.'
  - id: quality_threshold
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --quality-threshold
    doc: 'Quality score trimmer threshold Default value: 15.'
  - id: reads_per_partition_output
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --readsPerPartitionOutput
    doc: 'Number of reads per partition for output. Use this to control the number
      of sharded BAMs (not --num-reducers). Default value: 1000000.'
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
  - id: score_metrics
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --score-metrics
    doc: Log counts of mapped and unmapped reads to this file
  - id: score_warnings
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --score-warnings
    doc: Write accessions found in the reads header but not the taxonomy database
      to this file
  - id: skip_quality_filters
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --skip-quality-filters
    doc: 'Skip low-quality and low-complexity read filtering Default value: false.
      Possible values: {true, false}'
  - id: filter_reads_per_partition
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --filter-reads-per-partition
    doc: 'Estimated reads per partition after quality, kmer, and BWA filtering Default
      value: 200000.'
  - id: score_reads_per_partition_estimate
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --score-reads-per-partition-estimate
    doc: 'Estimated reads per Spark partition for scoring Default value: 200000.'
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
  - id: scores_output_out
    type: File
    doc: URI for the taxonomic scores output
    outputBinding:
      glob: $(inputs.scores_output)
  - id: filter_metrics_out
    type:
      - 'null'
      - File
    doc: Log counts of filtered reads to this file
    outputBinding:
      glob: $(inputs.filter_metrics)
  - id: output_output
    type:
      - 'null'
      - File
    doc: Output BAM
    outputBinding:
      glob: $(inputs.output)
  - id: score_metrics_out
    type:
      - 'null'
      - File
    doc: Log counts of mapped and unmapped reads to this file
    outputBinding:
      glob: $(inputs.score_metrics)
  - id: score_warnings_out
    type:
      - 'null'
      - File
    doc: Write accessions found in the reads header but not the taxonomy database
      to this file
    outputBinding:
      glob: $(inputs.score_warnings)
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
