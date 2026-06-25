cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - AddFlowSNVQuality
label: gatk_AddFlowSNVQuality
doc: This program converts the flow qualities that Ultima Genomics CRAM reports 
  to more conventional base qualities. Specifically, the generated quality will 
  report the probability that a specific base is a sequencing error mismatch, 
  while auxilary tags qa, qt, qg, qc report specific probability that a specific
  base X is a A->X error.
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: BAM/SAM/CRAM file containing reads
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: File to which reads should be written
    inputBinding:
      position: 101
      prefix: --output
  - id: add_output_sam_program_record
    type:
      - 'null'
      - boolean
    doc: If true, adds a PG tag to created SAM/BAM/CRAM files.
    inputBinding:
      position: 101
      prefix: --add-output-sam-program-record
  - id: add_output_vcf_command_line
    type:
      - 'null'
      - boolean
    doc: If true, adds a command line header line to created VCF files.
    inputBinding:
      position: 101
      prefix: --add-output-vcf-command-line
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: cloud_index_prefetch_buffer
    type:
      - 'null'
      - int
    doc: Size of the cloud-only prefetch buffer (in MB; 0 to disable).
    inputBinding:
      position: 101
      prefix: --cloud-index-prefetch-buffer
  - id: cloud_prefetch_buffer
    type:
      - 'null'
      - int
    doc: Size of the cloud-only prefetch buffer (in MB; 0 to disable).
    inputBinding:
      position: 101
      prefix: --cloud-prefetch-buffer
  - id: create_output_bam_index
    type:
      - 'null'
      - boolean
    doc: If true, create a BAM/CRAM index when writing a coordinate-sorted 
      BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --create-output-bam-index
  - id: create_output_bam_md5
    type:
      - 'null'
      - boolean
    doc: If true, create a MD5 digest for any BAM/SAM/CRAM file created
    inputBinding:
      position: 101
      prefix: --create-output-bam-md5
  - id: create_output_variant_index
    type:
      - 'null'
      - boolean
    doc: If true, create a VCF index when writing a coordinate-sorted VCF file.
    inputBinding:
      position: 101
      prefix: --create-output-variant-index
  - id: create_output_variant_md5
    type:
      - 'null'
      - boolean
    doc: If true, create a a MD5 digest any VCF file created.
    inputBinding:
      position: 101
      prefix: --create-output-variant-md5
  - id: disable_bam_index_caching
    type:
      - 'null'
      - boolean
    doc: If true, don't cache bam indexes, this will reduce memory requirements 
      but may harm performance if many intervals are specified.
    inputBinding:
      position: 101
      prefix: --disable-bam-index-caching
  - id: disable_read_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Read filters to be disabled before analysis
    inputBinding:
      position: 101
      prefix: --disable-read-filter
  - id: disable_sequence_dictionary_validation
    type:
      - 'null'
      - boolean
    doc: If specified, do not check the sequence dictionaries from our inputs 
      for compatibility.
    inputBinding:
      position: 101
      prefix: --disable-sequence-dictionary-validation
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals to exclude from processing
    inputBinding:
      position: 101
      prefix: --exclude-intervals
  - id: gatk_config_file
    type:
      - 'null'
      - string
    doc: A configuration file to use with the GATK.
    inputBinding:
      position: 101
      prefix: --gatk-config-file
  - id: gcs_max_retries
    type:
      - 'null'
      - int
    doc: If the GCS bucket channel errors out, how many times it will attempt to
      re-initiate the connection
    inputBinding:
      position: 101
      prefix: --gcs-max-retries
  - id: gcs_project_for_requester_pays
    type:
      - 'null'
      - string
    doc: Project to bill when accessing "requester pays" buckets.
    inputBinding:
      position: 101
      prefix: --gcs-project-for-requester-pays
  - id: interval_exclusion_padding
    type:
      - 'null'
      - int
    doc: Amount of padding (in bp) to add to each interval you are excluding.
    inputBinding:
      position: 101
      prefix: --interval-exclusion-padding
  - id: interval_merging_rule
    type:
      - 'null'
      - string
    doc: Interval merging rule for abutting intervals
    inputBinding:
      position: 101
      prefix: --interval-merging-rule
  - id: interval_padding
    type:
      - 'null'
      - int
    doc: Amount of padding (in bp) to add to each interval you are including.
    inputBinding:
      position: 101
      prefix: --interval-padding
  - id: interval_set_rule
    type:
      - 'null'
      - string
    doc: Set merging approach to use for combining interval inputs
    inputBinding:
      position: 101
      prefix: --interval-set-rule
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals over which to operate
    inputBinding:
      position: 101
      prefix: --intervals
  - id: inverted_read_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Inverted (with flipped acceptance/failure conditions) read filters 
      applied before analysis (after regular read filters).
    inputBinding:
      position: 101
      prefix: --inverted-read-filter
  - id: keep_supplementary_alignments
    type:
      - 'null'
      - boolean
    doc: keep supplementary alignments ?
    inputBinding:
      position: 101
      prefix: --keep-supplementary-alignments
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: Lenient processing of VCF files
    inputBinding:
      position: 101
      prefix: --lenient
  - id: max_phred_score
    type:
      - 'null'
      - float
    doc: Limit value for phred scores
    inputBinding:
      position: 101
      prefix: --max-phred-score
  - id: max_variants_per_shard
    type:
      - 'null'
      - int
    doc: If non-zero, partitions VCF output into shards, each containing up to 
      the given number of records.
    inputBinding:
      position: 101
      prefix: --max-variants-per-shard
  - id: output_quality_attribute
    type:
      - 'null'
      - string
    doc: alternate SAM tag to put original quality scores instead of overwriting
      the QUAL field.
    inputBinding:
      position: 101
      prefix: --output-quality-attribute
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: read_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Read filters to be applied before analysis
    inputBinding:
      position: 101
      prefix: --read-filter
  - id: read_index
    type:
      - 'null'
      - type: array
        items: File
    doc: Indices to use for the read inputs.
    inputBinding:
      position: 101
      prefix: --read-index
  - id: read_validation_stringency
    type:
      - 'null'
      - string
    doc: Validation stringency for all SAM/BAM/CRAM/SRA files read by this 
      program.
    inputBinding:
      position: 101
      prefix: --read-validation-stringency
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: Reference sequence
    inputBinding:
      position: 101
      prefix: --reference
  - id: seconds_between_progress_updates
    type:
      - 'null'
      - float
    doc: Output traversal statistics every time this many seconds elapse
    inputBinding:
      position: 101
      prefix: --seconds-between-progress-updates
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    doc: Use the given sequence dictionary as the master/canonical sequence 
      dictionary. Must be a .dict file.
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
  - id: sites_only_vcf_output
    type:
      - 'null'
      - boolean
    doc: If true, don't emit genotype fields when writing vcf file output.
    inputBinding:
      position: 101
      prefix: --sites-only-vcf-output
  - id: snvq_mode
    type:
      - 'null'
      - string
    doc: snvq calculation mode.
    inputBinding:
      position: 101
      prefix: --snvq-mode
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temp directory to use.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkDeflater (as opposed to IntelDeflater)
    inputBinding:
      position: 101
      prefix: --use-jdk-deflater
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Whether to use the JdkInflater (as opposed to IntelInflater)
    inputBinding:
      position: 101
      prefix: --use-jdk-inflater
  - id: disable_tool_default_read_filters
    type:
      - 'null'
      - boolean
    doc: Disable all tool default read filters
    inputBinding:
      position: 101
      prefix: --disable-tool-default-read-filters
  - id: flow_disallow_probs_larger_than_call
    type:
      - 'null'
      - boolean
    doc: Cap probabilities of error to 1 relative to base call
    inputBinding:
      position: 101
      prefix: --flow-disallow-probs-larger-than-call
  - id: flow_fill_empty_bins_value
    type:
      - 'null'
      - float
    doc: Value to fill the zeros of the matrix with
    inputBinding:
      position: 101
      prefix: --flow-fill-empty-bins-value
  - id: flow_lump_probs
    type:
      - 'null'
      - boolean
    doc: Should all probabilities of insertion or deletion in the flow be 
      combined together
    inputBinding:
      position: 101
      prefix: --flow-lump-probs
  - id: flow_matrix_mods
    type:
      - 'null'
      - string
    doc: Modifications instructions to the read flow matrix. Format is 
      src,dst{,src,dst}+.
    inputBinding:
      position: 101
      prefix: --flow-matrix-mods
  - id: flow_probability_scaling_factor
    type:
      - 'null'
      - int
    doc: probability scaling factor for (phred=10) for probability quantization
    inputBinding:
      position: 101
      prefix: --flow-probability-scaling-factor
  - id: flow_quantization_bins
    type:
      - 'null'
      - int
    doc: Number of bins for probability quantization
    inputBinding:
      position: 101
      prefix: --flow-quantization-bins
  - id: flow_remove_non_single_base_pair_indels
    type:
      - 'null'
      - boolean
    doc: Should the probabilities of more then 1 indel be used
    inputBinding:
      position: 101
      prefix: --flow-remove-non-single-base-pair-indels
  - id: flow_remove_one_zero_probs
    type:
      - 'null'
      - boolean
    doc: Remove probabilities of basecall of zero from non-zero genome
    inputBinding:
      position: 101
      prefix: --flow-remove-one-zero-probs
  - id: flow_report_insertion_or_deletion
    type:
      - 'null'
      - boolean
    doc: Report either insertion or deletion, probability, not both
    inputBinding:
      position: 101
      prefix: --flow-report-insertion-or-deletion
  - id: flow_retain_max_n_probs_base_format
    type:
      - 'null'
      - boolean
    doc: Keep only hmer/2 probabilities (like in base format)
    inputBinding:
      position: 101
      prefix: --flow-retain-max-n-probs-base-format
  - id: flow_symmetric_indel_probs
    type:
      - 'null'
      - boolean
    doc: Should indel probabilities be symmetric in flow
    inputBinding:
      position: 101
      prefix: --flow-symmetric-indel-probs
  - id: flow_use_t0_tag
    type:
      - 'null'
      - boolean
    doc: Use t0 tag if exists in the read to create flow matrix
    inputBinding:
      position: 101
      prefix: --flow-use-t0-tag
  - id: include_qc_failed_read
    type:
      - 'null'
      - boolean
    doc: include reads with QC failed flag
    inputBinding:
      position: 101
      prefix: --include-qc-failed-read
  - id: keep_boundary_flows
    type:
      - 'null'
      - boolean
    doc: prevent spreading of boundary flows.
    inputBinding:
      position: 101
      prefix: --keep-boundary-flows
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
outputs:
  - id: output_output
    type: File
    doc: File to which reads should be written
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
