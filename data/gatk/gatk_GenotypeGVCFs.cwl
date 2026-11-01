cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- GenotypeGVCFs
label: gatk_GenotypeGVCFs
doc: 'Perform joint genotyping on a single-sample GVCF from HaplotypeCaller or a multi-sample GVCF from
  CombineGVCFs or GenomicsDBImport


  Tool homepage: https://github.com/broadinstitute/gatk'
inputs:
- id: output
  type: string
  doc: File to which variants should be written
  inputBinding:
    position: 1
    prefix: --output
- id: reference
  type: File
  doc: Reference sequence file
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
  inputBinding:
    position: 1
    prefix: --reference
- id: variant
  type:
  - 'null'
  - File
  doc: A VCF file containing variants
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  inputBinding:
    position: 1
    prefix: --variant
- id: add_output_sam_program_record
  type:
  - 'null'
  - string
  doc: If true, adds a PG tag to created SAM/BAM/CRAM files. (true or false)
  inputBinding:
    position: 1
    prefix: --add-output-sam-program-record
- id: add_output_vcf_command_line
  type:
  - 'null'
  - string
  doc: If true, adds a command line header line to created VCF files. (true or false)
  inputBinding:
    position: 1
    prefix: --add-output-vcf-command-line
- id: allele_fraction_error
  type:
  - 'null'
  - double
  doc: Margin of error in allele fraction to consider a somatic variant homoplasmic
  inputBinding:
    position: 1
    prefix: --allele-fraction-error
- id: annotate_with_num_discovered_alleles
  type:
  - 'null'
  - boolean
  doc: If provided, we will annotate records with the number of alternate alleles that were discovered
    (but not necessarily genotyped) at a given site
  inputBinding:
    position: 1
    prefix: --annotate-with-num-discovered-alleles
- id: annotation
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotation
  doc: One or more specific annotations to add to variant calls
  inputBinding:
    position: 1
- id: annotation_group
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotation-group
  doc: One or more groups of annotations to apply to variant calls
  inputBinding:
    position: 1
- id: annotations_to_exclude
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotations-to-exclude
  doc: One or more specific annotations to exclude from variant calls
  inputBinding:
    position: 1
- id: arguments_file
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --arguments_file
  doc: read one or more arguments files and add them to the command line
  inputBinding:
    position: 1
- id: call_genotypes
  type:
  - 'null'
  - boolean
  doc: Output called genotypes in final VCF (otherwise no-call)
  inputBinding:
    position: 1
    prefix: --call-genotypes
- id: cloud_index_prefetch_buffer
  type:
  - 'null'
  - int
  doc: Size of the cloud-only prefetch buffer (in MB; 0 to disable). Defaults to cloudPrefetchBuffer if
    unset.
  inputBinding:
    position: 1
    prefix: --cloud-index-prefetch-buffer
- id: cloud_prefetch_buffer
  type:
  - 'null'
  - int
  doc: Size of the cloud-only prefetch buffer (in MB; 0 to disable).
  inputBinding:
    position: 1
    prefix: --cloud-prefetch-buffer
- id: create_output_bam_index
  type:
  - 'null'
  - string
  doc: If true, create a BAM/CRAM index when writing a coordinate-sorted BAM/CRAM file. (true or false)
  inputBinding:
    position: 1
    prefix: --create-output-bam-index
- id: create_output_bam_md5
  type:
  - 'null'
  - boolean
  doc: If true, create a MD5 digest for any BAM/SAM/CRAM file created
  inputBinding:
    position: 1
    prefix: --create-output-bam-md5
- id: create_output_variant_index
  type:
  - 'null'
  - string
  doc: If true, create a VCF index when writing a coordinate-sorted VCF file. (true or false)
  inputBinding:
    position: 1
    prefix: --create-output-variant-index
- id: create_output_variant_md5
  type:
  - 'null'
  - boolean
  doc: If true, create a a MD5 digest any VCF file created.
  inputBinding:
    position: 1
    prefix: --create-output-variant-md5
- id: dbsnp
  type:
  - 'null'
  - File
  doc: dbSNP file
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  inputBinding:
    position: 1
    prefix: --dbsnp
- id: disable_bam_index_caching
  type:
  - 'null'
  - boolean
  doc: If true, don't cache bam indexes, this will reduce memory requirements but may harm performance
    if many intervals are specified. Caching is automatically disabled if there are no intervals specified.
  inputBinding:
    position: 1
    prefix: --disable-bam-index-caching
- id: disable_read_filter
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --disable-read-filter
  doc: Read filters to be disabled before analysis
  inputBinding:
    position: 1
- id: disable_sequence_dictionary_validation
  type:
  - 'null'
  - boolean
  doc: If specified, do not check the sequence dictionaries from our inputs for compatibility. Use at
    your own risk!
  inputBinding:
    position: 1
    prefix: --disable-sequence-dictionary-validation
- id: exclude_intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --exclude-intervals
  doc: One or more genomic intervals to exclude from processing
  inputBinding:
    position: 1
- id: flow_order_for_annotations
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --flow-order-for-annotations
  doc: flow order used for this annotations. [readGroup:]flowOrder
  inputBinding:
    position: 1
- id: force_output_intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --force-output-intervals
  doc: sites at which to output genotypes even if non-variant in samples
  inputBinding:
    position: 1
- id: founder_id
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --founder-id
  doc: Samples representing the population "founders"
  inputBinding:
    position: 1
- id: gatk_config_file
  type:
  - 'null'
  - File
  doc: A configuration file to use with the GATK.
  inputBinding:
    position: 1
    prefix: --gatk-config-file
- id: gcs_max_retries
  type:
  - 'null'
  - int
  doc: If the GCS bucket channel errors out, how many times it will attempt to re-initiate the connection
  inputBinding:
    position: 1
    prefix: --gcs-max-retries
- id: gcs_project_for_requester_pays
  type:
  - 'null'
  - string
  doc: Project to bill when accessing "requester pays" buckets. If unset, these buckets cannot be accessed.
    User must have storage.buckets.get permission on the bucket being accessed.
  inputBinding:
    position: 1
    prefix: --gcs-project-for-requester-pays
- id: genomicsdb_max_alternate_alleles
  type:
  - 'null'
  - int
  doc: Maximum number of alternate alleles that will be combined on reading from GenomicsDB
  inputBinding:
    position: 1
    prefix: --genomicsdb-max-alternate-alleles
- id: genomicsdb_shared_posixfs_optimizations
  type:
  - 'null'
  - boolean
  doc: Allow for optimizations to improve the usability and performance for shared Posix Filesystems(e.g.
    NFS, Lustre). If set, file level locking is disabled and file system writes are minimized.
  inputBinding:
    position: 1
    prefix: --genomicsdb-shared-posixfs-optimizations
- id: genomicsdb_use_gcs_hdfs_connector
  type:
  - 'null'
  - boolean
  doc: Use the GCS HDFS Connector instead of the native GCS SDK client with gs:// URLs.
  inputBinding:
    position: 1
    prefix: --genomicsdb-use-gcs-hdfs-connector
- id: genotype_assignment_method
  type:
  - 'null'
  - string
  doc: How we assign genotypes
  inputBinding:
    position: 1
    prefix: --genotype-assignment-method
- id: heterozygosity
  type:
  - 'null'
  - double
  doc: Heterozygosity value used to compute prior probabilities for any locus. See the GATKDocs for full
    details on the meaning of this population genetics concept
  inputBinding:
    position: 1
    prefix: --heterozygosity
- id: heterozygosity_stdev
  type:
  - 'null'
  - double
  doc: Standard deviation of heterozygosity for SNP and indel calling.
  inputBinding:
    position: 1
    prefix: --heterozygosity-stdev
- id: include_non_variant_sites
  type:
  - 'null'
  - boolean
  doc: Include loci found to be non-variant after genotyping
  inputBinding:
    position: 1
    prefix: --include-non-variant-sites
- id: indel_heterozygosity
  type:
  - 'null'
  - double
  doc: Heterozygosity for indel calling. See the GATKDocs for heterozygosity for full details on the meaning
    of this population genetics concept
  inputBinding:
    position: 1
    prefix: --indel-heterozygosity
- id: input
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --input
  doc: BAM/SAM/CRAM file containing reads
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.crai
    required: false
  inputBinding:
    position: 1
- id: input_is_somatic
  type:
  - 'null'
  - boolean
  doc: Finalize input GVCF according to somatic (i.e. Mutect2) TLODs (BETA feature)
  inputBinding:
    position: 1
    prefix: --input-is-somatic
- id: interval_exclusion_padding
  type:
  - 'null'
  - int
  doc: Amount of padding (in bp) to add to each interval you are excluding.
  inputBinding:
    position: 1
    prefix: --interval-exclusion-padding
- id: interval_merging_rule
  type:
  - 'null'
  - string
  doc: Interval merging rule for abutting intervals
  inputBinding:
    position: 1
    prefix: --interval-merging-rule
- id: interval_padding
  type:
  - 'null'
  - int
  doc: Amount of padding (in bp) to add to each interval you are including.
  inputBinding:
    position: 1
    prefix: --interval-padding
- id: interval_set_rule
  type:
  - 'null'
  - string
  doc: Set merging approach to use for combining interval inputs
  inputBinding:
    position: 1
    prefix: --interval-set-rule
- id: intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate
  inputBinding:
    position: 1
- id: inverted_read_filter
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --inverted-read-filter
  doc: Inverted (with flipped acceptance/failure conditions) read filters applied before analysis (after
    regular read filters).
  inputBinding:
    position: 1
- id: keep_combined_raw_annotations
  type:
  - 'null'
  - boolean
  doc: If specified, keep the combined raw annotations
  inputBinding:
    position: 1
    prefix: --keep-combined-raw-annotations
- id: keep_specific_combined_raw_annotation
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --keep-specific-combined-raw-annotation
  doc: Keep only the specific combined raw annotations specified (removing the other raw annotations).
    Duplicate values will be ignored.
  inputBinding:
    position: 1
- id: lenient
  type:
  - 'null'
  - boolean
  doc: Lenient processing of VCF files
  inputBinding:
    position: 1
    prefix: --lenient
- id: max_variants_per_shard
  type:
  - 'null'
  - int
  doc: If non-zero, partitions VCF output into shards, each containing up to the given number of records.
  inputBinding:
    position: 1
    prefix: --max-variants-per-shard
- id: merge_input_intervals
  type:
  - 'null'
  - boolean
  doc: Boolean flag to import all data in between intervals.
  inputBinding:
    position: 1
    prefix: --merge-input-intervals
- id: num_reference_samples_if_no_call
  type:
  - 'null'
  - int
  doc: Number of hom-ref genotypes to infer at sites not present in a panel
  inputBinding:
    position: 1
    prefix: --num-reference-samples-if-no-call
- id: output_cram_version
  type:
  - 'null'
  - string
  doc: The CRAM version ('3.0' or '3.1') to write for CRAM output. Ignored for BAM/SAM output. Note that
    CRAM 3.1 (the default) cannot be read by tools that only support CRAM 3.0.
  inputBinding:
    position: 1
    prefix: --output-cram-version
- id: pedigree
  type:
  - 'null'
  - File
  doc: Pedigree file for determining the population "founders"
  inputBinding:
    position: 1
    prefix: --pedigree
- id: population_callset
  type:
  - 'null'
  - File
  doc: Callset to use in calculating genotype priors
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  inputBinding:
    position: 1
    prefix: --population-callset
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Whether to suppress job-summary info on System.err.
  inputBinding:
    position: 1
    prefix: --QUIET
- id: read_filter
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --read-filter
  doc: Read filters to be applied before analysis
  inputBinding:
    position: 1
- id: read_index
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --read-index
  doc: Indices to use for the read inputs. If specified, an index must be provided for every read input
    and in the same order as the read inputs. If this argument is not specified, the path to the index
    for each input will be inferred automatically.
  inputBinding:
    position: 1
- id: read_validation_stringency
  type:
  - 'null'
  - string
  doc: Validation stringency for all SAM/BAM/CRAM/SRA files read by this program. The default stringency
    value SILENT can improve performance when processing a BAM file in which variable-length data (read,
    qualities, tags) do not otherwise need to be decoded.
  inputBinding:
    position: 1
    prefix: --read-validation-stringency
- id: sample_ploidy
  type:
  - 'null'
  - int
  doc: Ploidy (number of chromosomes) per sample. For pooled data, set to (Number of samples in each pool
    * Sample Ploidy).
  inputBinding:
    position: 1
    prefix: --sample-ploidy
- id: seconds_between_progress_updates
  type:
  - 'null'
  - double
  doc: Output traversal statistics every time this many seconds elapse
  inputBinding:
    position: 1
    prefix: --seconds-between-progress-updates
- id: sequence_dictionary
  type:
  - 'null'
  - File
  doc: Use the given sequence dictionary as the master/canonical sequence dictionary. Must be a .dict
    file.
  inputBinding:
    position: 1
    prefix: --sequence-dictionary
- id: sites_only_vcf_output
  type:
  - 'null'
  - boolean
  doc: If true, don't emit genotype fields when writing vcf file output.
  inputBinding:
    position: 1
    prefix: --sites-only-vcf-output
- id: somatic_quality_threshold
  type:
  - 'null'
  - double
  doc: SQ threshold to emit variant to VCF.
  inputBinding:
    position: 1
    prefix: --somatic-quality-threshold
- id: standard_min_confidence_threshold_for_calling
  type:
  - 'null'
  - double
  doc: The minimum phred-scaled confidence threshold at which variants should be called
  inputBinding:
    position: 1
    prefix: --standard-min-confidence-threshold-for-calling
- id: tmp_dir
  type:
  - 'null'
  - string
  doc: Temp directory to use.
  inputBinding:
    position: 1
    prefix: --tmp-dir
- id: tumor_lod_to_emit
  type:
  - 'null'
  - double
  doc: LOD threshold to emit variant to VCF.
  inputBinding:
    position: 1
    prefix: --tumor-lod-to-emit
- id: use_jdk_deflater
  type:
  - 'null'
  - boolean
  doc: Whether to use the JdkDeflater (as opposed to IntelDeflater)
  inputBinding:
    position: 1
    prefix: --use-jdk-deflater
- id: use_jdk_inflater
  type:
  - 'null'
  - boolean
  doc: Whether to use the JdkInflater (as opposed to IntelInflater)
  inputBinding:
    position: 1
    prefix: --use-jdk-inflater
- id: use_new_qual_calculator
  type:
  - 'null'
  - string
  doc: This argument is DEPRECATED (New qual score is on by default). Use the new AF model instead of
    the so-called exact model (true or false)
  inputBinding:
    position: 1
    prefix: --use-new-qual-calculator
- id: use_posteriors_to_calculate_qual
  type:
  - 'null'
  - boolean
  doc: if available, use the genotype posterior probabilities to calculate the site QUAL
  inputBinding:
    position: 1
    prefix: --use-posteriors-to-calculate-qual
- id: verbosity
  type:
  - 'null'
  - string
  doc: Control verbosity of logging.
  inputBinding:
    position: 1
    prefix: --verbosity
- id: disable_tool_default_annotations
  type:
  - 'null'
  - boolean
  doc: Disable all tool default annotations
  inputBinding:
    position: 1
    prefix: --disable-tool-default-annotations
- id: disable_tool_default_read_filters
  type:
  - 'null'
  - boolean
  doc: 'Disable all tool default read filters (WARNING: many tools will not function correctly without
    their default read filters on)'
  inputBinding:
    position: 1
    prefix: --disable-tool-default-read-filters
- id: dont_use_dragstr_priors
  type:
  - 'null'
  - boolean
  doc: Forfeit the use of the DRAGstr model to calculate genotype priors. This argument does not have
    any effect in the absence of DRAGstr model parameters (--dragstr-model-params)
  inputBinding:
    position: 1
    prefix: --dont-use-dragstr-priors
- id: enable_all_annotations
  type:
  - 'null'
  - boolean
  doc: Use all possible annotations (not for the faint of heart)
  inputBinding:
    position: 1
    prefix: --enable-all-annotations
- id: genomicsdb_use_bcf_codec
  type:
  - 'null'
  - boolean
  doc: Use BCF Codec Streaming for data from GenomicsDB instead of the default VCFCodec. BCFCodec performs
    slightly better but currently does not support 64-bit width positions and INFO fields and for computed
    annotation sizes to exceed 32-bit integer space.
  inputBinding:
    position: 1
    prefix: --genomicsdb-use-bcf-codec
- id: max_alternate_alleles
  type:
  - 'null'
  - int
  doc: Maximum number of alternate alleles to genotype
  inputBinding:
    position: 1
    prefix: --max-alternate-alleles
- id: max_genotype_count
  type:
  - 'null'
  - int
  doc: Maximum number of genotypes to consider at any site
  inputBinding:
    position: 1
    prefix: --max-genotype-count
- id: only_output_calls_starting_in_intervals
  type:
  - 'null'
  - boolean
  doc: This argument is DEPRECATED (This feature is deprecated and will be removed in a future release.).
    Restrict variant output to sites that start within provided intervals, equivalent to '--variant-output-filtering
    STARTS_IN'
  inputBinding:
    position: 1
    prefix: --only-output-calls-starting-in-intervals
- id: variant_output_filtering
  type:
  - 'null'
  - string
  doc: Restrict the output variants to ones that match the specified intervals according to the specified
    matching mode.
  inputBinding:
    position: 1
    prefix: --variant-output-filtering
- id: dirichlet_keep_prior_in_count
  type:
  - 'null'
  - boolean
  doc: By default we don't keep the prior use in the output counts ase it makes it easier to interpretthis
    quantity as the number of supporting reads specially in low depth sites. We this toggled the prior
    is included
  inputBinding:
    position: 1
    prefix: --dirichlet-keep-prior-in-count
- id: dirichlet_prior_pseudo_count
  type:
  - 'null'
  - double
  doc: Pseudo-count used as prior for all alleles. The default is 1.0 resulting in a flat prior
  inputBinding:
    position: 1
    prefix: --dirichlet-prior-pseudo-count
- id: pseudo_count_weight_decay_rate
  type:
  - 'null'
  - double
  doc: A what rate the weight of a read decreases base on its informativeness; e.g. 1.0 is linear decay
    (default), 2.0 is for quadratic decay
  inputBinding:
    position: 1
    prefix: --pseudo-count-weight-decay-rate
- id: assembly_complexity_reference_mode
  type:
  - 'null'
  - boolean
  doc: If enabled will treat the reference as the basis for assembly complexity as opposed to estimated
    germline haplotypes
  inputBinding:
    position: 1
    prefix: --assembly-complexity-reference-mode
- id: denovo_depth_threshold
  type:
  - 'null'
  - int
  doc: Minimum depth (DP) for all trio members to be considered for de novo calculation.
  inputBinding:
    position: 1
    prefix: --denovo-depth-threshold
- id: denovo_parent_gq_threshold
  type:
  - 'null'
  - int
  doc: Minimum genotype quality for parents to be considered for de novo calculation (separate from GQ
    thershold for full trio).
  inputBinding:
    position: 1
    prefix: --denovo-parent-gq-threshold
- id: allow_old_rms_mapping_quality_annotation_data
  type:
  - 'null'
  - boolean
  doc: Override to allow old RMSMappingQuality annotated VCFs to function
  inputBinding:
    position: 1
    prefix: --allow-old-rms-mapping-quality-annotation-data
- id: ambig_filter_bases
  type:
  - 'null'
  - int
  doc: Threshold number of ambiguous bases. If null, uses threshold fraction; otherwise, overrides threshold
    fraction.
  inputBinding:
    position: 1
    prefix: --ambig-filter-bases
- id: ambig_filter_frac
  type:
  - 'null'
  - double
  doc: Threshold fraction of ambiguous bases
  inputBinding:
    position: 1
    prefix: --ambig-filter-frac
- id: max_clipped_bases
  type:
  - 'null'
  - int
  doc: Maximum number of clipped bases on either end of a given read
  inputBinding:
    position: 1
    prefix: --max-clipped-bases
- id: read_filter_max_hmer
  type:
  - 'null'
  - int
  doc: maxHmer to use for testing in the filter
  inputBinding:
    position: 1
    prefix: --read-filter-max-hmer
- id: max_fragment_length
  type:
  - 'null'
  - int
  doc: Maximum length of fragment (insert size)
  inputBinding:
    position: 1
    prefix: --max-fragment-length
- id: min_fragment_length
  type:
  - 'null'
  - int
  doc: Minimum length of fragment (insert size)
  inputBinding:
    position: 1
    prefix: --min-fragment-length
- id: keep_intervals
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --keep-intervals
  doc: One or more genomic intervals to keep
  inputBinding:
    position: 1
- id: read_filter_expression
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --read-filter-expression
  doc: One or more JEXL expressions used to filter
  inputBinding:
    position: 1
- id: library
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --library
  doc: Name of the library to keep
  inputBinding:
    position: 1
- id: maximum_mapping_quality
  type:
  - 'null'
  - int
  doc: Maximum mapping quality to keep (inclusive)
  inputBinding:
    position: 1
    prefix: --maximum-mapping-quality
- id: minimum_mapping_quality
  type:
  - 'null'
  - int
  doc: Minimum mapping quality to keep (inclusive)
  inputBinding:
    position: 1
    prefix: --minimum-mapping-quality
- id: mate_too_distant_length
  type:
  - 'null'
  - int
  doc: Minimum start location difference at which mapped mates are considered distant
  inputBinding:
    position: 1
    prefix: --mate-too-distant-length
- id: dont_require_soft_clips_both_ends
  type:
  - 'null'
  - boolean
  doc: Allow a read to be filtered out based on having only 1 soft-clipped block. By default, both ends
    must have a soft-clipped block, setting this flag requires only 1 soft-clipped block
  inputBinding:
    position: 1
    prefix: --dont-require-soft-clips-both-ends
- id: filter_too_short
  type:
  - 'null'
  - int
  doc: Minimum number of aligned bases
  inputBinding:
    position: 1
    prefix: --filter-too-short
- id: platform_filter_name
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --platform-filter-name
  doc: Platform attribute (PL) to match
  inputBinding:
    position: 1
- id: black_listed_lanes
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --black-listed-lanes
  doc: Platform unit (PU) to filter out
  inputBinding:
    position: 1
- id: read_group_black_list
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --read-group-black-list
  doc: A read group filter expression in the form "attribute:value", where "attribute" is a two character
    read group attribute such as "RG" or "PU".
  inputBinding:
    position: 1
- id: keep_read_group
  type:
  - 'null'
  - string
  doc: The name of the read group to keep
  inputBinding:
    position: 1
    prefix: --keep-read-group
- id: max_read_length
  type:
  - 'null'
  - int
  doc: Keep only reads with length at most equal to the specified value
  inputBinding:
    position: 1
    prefix: --max-read-length
- id: min_read_length
  type:
  - 'null'
  - int
  doc: Keep only reads with length at least equal to the specified value
  inputBinding:
    position: 1
    prefix: --min-read-length
- id: read_name
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --read-name
  doc: Keep only reads with this read name
  inputBinding:
    position: 1
- id: keep_reverse_strand_only
  type:
  - 'null'
  - boolean
  doc: Keep only reads on the reverse strand
  inputBinding:
    position: 1
    prefix: --keep-reverse-strand-only
- id: read_filter_tag
  type:
  - 'null'
  - string
  doc: Look for this tag in read
  inputBinding:
    position: 1
    prefix: --read-filter-tag
- id: read_filter_tag_comp
  type:
  - 'null'
  - float
  doc: Compare value in tag to this value
  inputBinding:
    position: 1
    prefix: --read-filter-tag-comp
- id: read_filter_tag_op
  type:
  - 'null'
  - string
  doc: Compare value in tag to value with this operator. If T is the value in the tag, OP is the operation
    provided, and V is the value in read-filter-tag, then the read will pass the filter iff T OP V is
    true.
  inputBinding:
    position: 1
    prefix: --read-filter-tag-op
- id: sample
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --sample
  doc: The name of the sample(s) to keep, filtering out all others
  inputBinding:
    position: 1
- id: max_soft_clipped_leading_trailing_ratio
  type:
  - 'null'
  - double
  doc: Threshold ratio of soft clipped bases (leading / trailing the cigar string) to total bases in read
    for read to be filtered.
  inputBinding:
    position: 1
    prefix: --max-soft-clipped-leading-trailing-ratio
- id: max_soft_clipped_ratio
  type:
  - 'null'
  - double
  doc: Threshold ratio of soft clipped bases (anywhere in the cigar string) to total bases in read for
    read to be filtered.
  inputBinding:
    position: 1
    prefix: --max-soft-clipped-ratio
- id: variant_genomicsdb
  type:
  - 'null'
  - Directory
  doc: GenomicsDB workspace (made by GenomicsDBImport) to read the variants from; passed to --variant
    as gendb://<path>.
  inputBinding:
    position: 1
    valueFrom: gendb://$(self.path)
    prefix: --variant
outputs:
- id: output_file
  type: File
  doc: File to which variants should be written
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
