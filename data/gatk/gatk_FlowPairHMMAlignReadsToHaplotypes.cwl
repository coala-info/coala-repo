cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - FlowPairHMMAlignReadsToHaplotypes
label: gatk_FlowPairHMMAlignReadsToHaplotypes
doc: Align Reads to Haplotypes using FlowBasedPairHMM
inputs:
  - id: haplotypes
    type: File
    doc: Fasta file with haplotypes
    inputBinding:
      position: 101
      prefix: --haplotypes
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM/SAM/CRAM file containing reads
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: Read x haplotype log-likelihood matrix
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
  - id: aligner
    type:
      - 'null'
      - string
    doc: 'Aligner: FlowBasedHMM or FlowBasedAligner (FlowBased)'
    inputBinding:
      position: 101
      prefix: --aligner
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: base_quality_score_threshold
    type:
      - 'null'
      - int
    doc: Base qualities below this threshold will be reduced to the minimum (6)
    inputBinding:
      position: 101
      prefix: --base-quality-score-threshold
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
  - id: concise_output_format
    type:
      - 'null'
      - boolean
    doc: concise or expanded output format
    inputBinding:
      position: 101
      prefix: --concise-output-format
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
    doc: If true, don't cache bam indexes
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
  - id: dont_use_dragstr_pair_hmm_scores
    type:
      - 'null'
      - boolean
    doc: disable DRAGstr pair-hmm score even when dragstr-params-path was 
      provided
    inputBinding:
      position: 101
      prefix: --dont-use-dragstr-pair-hmm-scores
  - id: dragstr_het_hom_ratio
    type:
      - 'null'
      - int
    doc: het to hom prior ratio use with DRAGstr on
    inputBinding:
      position: 101
      prefix: --dragstr-het-hom-ratio
  - id: dragstr_params_path
    type:
      - 'null'
      - File
    doc: location of the DRAGstr model parameters for STR error correction used 
      in the Pair HMM.
    inputBinding:
      position: 101
      prefix: --dragstr-params-path
  - id: enable_dynamic_read_disqualification_for_genotyping
    type:
      - 'null'
      - boolean
    doc: Will enable less strict read disqualification low base quality reads
    inputBinding:
      position: 101
      prefix: --enable-dynamic-read-disqualification-for-genotyping
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
      - File
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
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: Lenient processing of VCF files
    inputBinding:
      position: 101
      prefix: --lenient
  - id: max_variants_per_shard
    type:
      - 'null'
      - int
    doc: If non-zero, partitions VCF output into shards
    inputBinding:
      position: 101
      prefix: --max-variants-per-shard
  - id: native_pair_hmm_threads
    type:
      - 'null'
      - int
    doc: How many threads should a native pairHMM implementation use
    inputBinding:
      position: 101
      prefix: --native-pair-hmm-threads
  - id: native_pair_hmm_use_double_precision
    type:
      - 'null'
      - boolean
    doc: use double precision in the native pairHmm.
    inputBinding:
      position: 101
      prefix: --native-pair-hmm-use-double-precision
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
  - id: ref_haplotype
    type:
      - 'null'
      - File
    doc: Fasta file with haplotypes
    inputBinding:
      position: 101
      prefix: --ref-haplotype
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
      dictionary.
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
  - id: expected_mismatch_rate_for_read_disqualification
    type:
      - 'null'
      - float
    doc: Error rate used to set expectation for post HMM read disqualification 
      based on mismatches
    inputBinding:
      position: 101
      prefix: --expected-mismatch-rate-for-read-disqualification
  - id: pair_hmm_implementation
    type:
      - 'null'
      - string
    doc: The PairHMM implementation to use for genotype likelihood calculations
    inputBinding:
      position: 101
      prefix: --pair-hmm-implementation
  - id: pair_hmm_results_file
    type: string
    doc: File to write exact pairHMM inputs/outputs to for debugging purposes
    inputBinding:
      position: 101
      prefix: --pair-hmm-results-file
outputs:
  - id: output_output
    type: File
    doc: Read x haplotype log-likelihood matrix
    outputBinding:
      glob: $(inputs.output)
  - id: output_pair_hmm_results_file
    type:
      - 'null'
      - File
    doc: File to write exact pairHMM inputs/outputs to for debugging purposes
    outputBinding:
      glob: $(inputs.pair_hmm_results_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
