cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- HaplotypeCaller
label: gatk_HaplotypeCaller
doc: 'Call germline SNPs and indels via local re-assembly of haplotypes


  Tool homepage: https://github.com/broadinstitute/gatk'
inputs:
- id: input
  type:
    type: array
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
- id: alleles
  type:
  - 'null'
  - File
  doc: The set of alleles to force-call regardless of evidence
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  inputBinding:
    position: 1
    prefix: --alleles
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
- id: assembly_region_out
  type:
  - 'null'
  - string
  doc: Output the assembly region to this IGV formatted file
  inputBinding:
    position: 1
    prefix: --assembly-region-out
- id: assembly_region_padding
  type:
  - 'null'
  - int
  doc: Number of additional bases of context to include around each assembly region
  inputBinding:
    position: 1
    prefix: --assembly-region-padding
- id: base_quality_score_threshold
  type:
  - 'null'
  - int
  doc: Base qualities below this threshold will be reduced to the minimum (6)
  inputBinding:
    position: 1
    prefix: --base-quality-score-threshold
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
- id: contamination_fraction_to_filter
  type:
  - 'null'
  - double
  doc: Fraction of contamination in sequencing data (for all samples) to aggressively remove
  inputBinding:
    position: 1
    prefix: --contamination-fraction-to-filter
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
- id: dont_use_dragstr_pair_hmm_scores
  type:
  - 'null'
  - boolean
  doc: disable DRAGstr pair-hmm score even when dragstr-params-path was provided
  inputBinding:
    position: 1
    prefix: --dont-use-dragstr-pair-hmm-scores
- id: dont_use_soft_clipped_bases
  type:
  - 'null'
  - boolean
  doc: Do not analyze soft clipped bases in the reads
  inputBinding:
    position: 1
    prefix: --dont-use-soft-clipped-bases
- id: dragen_mode
  type:
  - 'null'
  - boolean
  doc: 'Single argument for enabling the bulk of DRAGEN-GATK features. NOTE: THIS WILL OVERWRITE PROVIDED
    ARGUMENT CHECK TOOL INFO TO SEE WHICH ARGUMENTS ARE SET).'
  inputBinding:
    position: 1
    prefix: --dragen-mode
- id: dragstr_het_hom_ratio
  type:
  - 'null'
  - int
  doc: het to hom prior ratio use with DRAGstr on
  inputBinding:
    position: 1
    prefix: --dragstr-het-hom-ratio
- id: dragstr_params_path
  type:
  - 'null'
  - File
  doc: location of the DRAGstr model parameters for STR error correction used in the Pair HMM. When provided,
    it overrides other PCR error correcting mechanisms
  inputBinding:
    position: 1
    prefix: --dragstr-params-path
- id: enable_dynamic_read_disqualification_for_genotyping
  type:
  - 'null'
  - boolean
  doc: Will enable less strict read disqualification low base quality reads
  inputBinding:
    position: 1
    prefix: --enable-dynamic-read-disqualification-for-genotyping
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
- id: genotype_assignment_method
  type:
  - 'null'
  - string
  doc: How we assign genotypes
  inputBinding:
    position: 1
    prefix: --genotype-assignment-method
- id: graph_output
  type:
  - 'null'
  - string
  doc: Write debug assembly graph information to this file
  inputBinding:
    position: 1
    prefix: --graph-output
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
- id: indel_heterozygosity
  type:
  - 'null'
  - double
  doc: Heterozygosity for indel calling. See the GATKDocs for heterozygosity for full details on the meaning
    of this population genetics concept
  inputBinding:
    position: 1
    prefix: --indel-heterozygosity
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
- id: lenient
  type:
  - 'null'
  - boolean
  doc: Lenient processing of VCF files
  inputBinding:
    position: 1
    prefix: --lenient
- id: max_assembly_region_size
  type:
  - 'null'
  - int
  doc: Maximum size of an assembly region
  inputBinding:
    position: 1
    prefix: --max-assembly-region-size
- id: max_reads_per_alignment_start
  type:
  - 'null'
  - int
  doc: Maximum number of reads to retain per alignment start position. Reads above this threshold will
    be downsampled. Set to 0 to disable.
  inputBinding:
    position: 1
    prefix: --max-reads-per-alignment-start
- id: max_variants_per_shard
  type:
  - 'null'
  - int
  doc: If non-zero, partitions VCF output into shards, each containing up to the given number of records.
  inputBinding:
    position: 1
    prefix: --max-variants-per-shard
- id: min_assembly_region_size
  type:
  - 'null'
  - int
  doc: Minimum size of an assembly region
  inputBinding:
    position: 1
    prefix: --min-assembly-region-size
- id: min_base_quality_score
  type:
  - 'null'
  - int
  doc: Minimum base quality required to consider a base for calling
  inputBinding:
    position: 1
    prefix: --min-base-quality-score
- id: native_pair_hmm_threads
  type:
  - 'null'
  - int
  doc: How many threads should a native pairHMM implementation use
  inputBinding:
    position: 1
    prefix: --native-pair-hmm-threads
- id: native_pair_hmm_use_double_precision
  type:
  - 'null'
  - boolean
  doc: use double precision in the native pairHmm. This is slower but matches the java implementation
    better
  inputBinding:
    position: 1
    prefix: --native-pair-hmm-use-double-precision
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
- id: output_mode
  type:
  - 'null'
  - string
  doc: Specifies which type of calls we should output
  inputBinding:
    position: 1
    prefix: --output-mode
- id: pedigree
  type:
  - 'null'
  - File
  doc: Pedigree file for determining the population "founders"
  inputBinding:
    position: 1
    prefix: --pedigree
- id: ploidy_regions
  type:
  - 'null'
  - File
  doc: Interval file with column specifying desired ploidy for genotyping models. Overrides default ploidy
    and user-provided --ploidy argument in specific regions.
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  inputBinding:
    position: 1
    prefix: --ploidy-regions
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
- id: recover_dangling_heads
  type:
  - 'null'
  - boolean
  doc: This argument is DEPRECATED (This feature is deprecated and will be removed in a future release.).
    This argument is deprecated since version 3.3
  inputBinding:
    position: 1
    prefix: --recover-dangling-heads
- id: sample_name
  type:
  - 'null'
  - string
  doc: Name of single sample to use from a multi-sample bam
  inputBinding:
    position: 1
    prefix: --sample-name
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
- id: use_pdhmm
  type:
  - 'null'
  - boolean
  doc: Partially Determined HMM, an alternative to the regular assembly haplotypes where we instead construct
    artificial haplotypes out of the union of the assembly and pileup alleles.
  inputBinding:
    position: 1
    prefix: --use-pdhmm
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
- id: active_probability_threshold
  type:
  - 'null'
  - double
  doc: Minimum probability for a locus to be considered active.
  inputBinding:
    position: 1
    prefix: --active-probability-threshold
- id: activeregion_alt_multiplier
  type:
  - 'null'
  - double
  doc: Multiplier for up-weighting ALT-supporting reads during active region determination
  inputBinding:
    position: 1
    prefix: --activeregion-alt-multiplier
- id: adaptive_pruning
  type:
  - 'null'
  - boolean
  doc: Use Mutect2's adaptive graph pruning algorithm
  inputBinding:
    position: 1
    prefix: --adaptive-pruning
- id: adaptive_pruning_initial_error_rate
  type:
  - 'null'
  - double
  doc: Initial base error rate estimate for adaptive pruning
  inputBinding:
    position: 1
    prefix: --adaptive-pruning-initial-error-rate
- id: all_site_pls
  type:
  - 'null'
  - boolean
  doc: Annotate all sites with PLs
  inputBinding:
    position: 1
    prefix: --all-site-pls
- id: allele_informative_reads_overlap_margin
  type:
  - 'null'
  - int
  doc: Likelihood and read-based annotations will only take into consideration reads that overlap the
    variant or any base no further than this distance expressed in base pairs
  inputBinding:
    position: 1
    prefix: --allele-informative-reads-overlap-margin
- id: allow_non_unique_kmers_in_ref
  type:
  - 'null'
  - boolean
  doc: Allow graphs that have non-unique kmers in the reference
  inputBinding:
    position: 1
    prefix: --allow-non-unique-kmers-in-ref
- id: apply_bqd
  type:
  - 'null'
  - boolean
  doc: If enabled this argument will apply the DRAGEN-GATK BaseQualityDropout model to the genotyping
    model for filtering sites due to Linked Error mode.
  inputBinding:
    position: 1
    prefix: --apply-bqd
- id: apply_frd
  type:
  - 'null'
  - boolean
  doc: If enabled this argument will apply the DRAGEN-GATK ForeignReadDetection model to the genotyping
    model for filtering sites.
  inputBinding:
    position: 1
    prefix: --apply-frd
- id: bam_output
  type:
  - 'null'
  - string
  doc: File to which assembled haplotypes should be written
  inputBinding:
    position: 1
    prefix: --bam-output
- id: bam_writer_type
  type:
  - 'null'
  - string
  doc: Which haplotypes should be written to the BAM
  inputBinding:
    position: 1
    prefix: --bam-writer-type
- id: comparison
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --comparison
  doc: Comparison VCF file(s)
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
  inputBinding:
    position: 1
- id: contamination_fraction_per_sample_file
  type:
  - 'null'
  - File
  doc: Tab-separated File containing fraction of contamination in sequencing data (per sample) to aggressively
    remove. Format should be "<SampleID><TAB><Contamination>" (Contamination is double) per line; No header.
  inputBinding:
    position: 1
    prefix: --contamination-fraction-per-sample-file
- id: debug_assembly
  type:
  - 'null'
  - boolean
  doc: Print out verbose debug information about each assembly region
  inputBinding:
    position: 1
    prefix: --debug-assembly
- id: disable_cap_base_qualities_to_map_quality
  type:
  - 'null'
  - boolean
  doc: If false this disables capping of base qualities in the HMM to the mapping quality of the read
  inputBinding:
    position: 1
    prefix: --disable-cap-base-qualities-to-map-quality
- id: disable_optimizations
  type:
  - 'null'
  - boolean
  doc: Don't skip calculations in ActiveRegions with no variants
  inputBinding:
    position: 1
    prefix: --disable-optimizations
- id: disable_spanning_event_genotyping
  type:
  - 'null'
  - boolean
  doc: If enabled this argument will disable inclusion of the '*' spanning event when genotyping events
    that overlap deletions
  inputBinding:
    position: 1
    prefix: --disable-spanning-event-genotyping
- id: disable_symmetric_hmm_normalizing
  type:
  - 'null'
  - boolean
  doc: Toggle to revive legacy behavior of asymmetrically normalizing the arguments to the reference haplotype
  inputBinding:
    position: 1
    prefix: --disable-symmetric-hmm-normalizing
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
- id: do_not_correct_overlapping_quality
  type:
  - 'null'
  - boolean
  doc: Disable overlapping base quality correction
  inputBinding:
    position: 1
    prefix: --do-not-correct-overlapping-quality
- id: do_not_run_physical_phasing
  type:
  - 'null'
  - boolean
  doc: Disable physical phasing
  inputBinding:
    position: 1
    prefix: --do-not-run-physical-phasing
- id: dont_increase_kmer_sizes_for_cycles
  type:
  - 'null'
  - boolean
  doc: Disable iterating over kmer sizes when graph cycles are detected
  inputBinding:
    position: 1
    prefix: --dont-increase-kmer-sizes-for-cycles
- id: dont_use_dragstr_priors
  type:
  - 'null'
  - boolean
  doc: Forfeit the use of the DRAGstr model to calculate genotype priors. This argument does not have
    any effect in the absence of DRAGstr model parameters (--dragstr-model-params)
  inputBinding:
    position: 1
    prefix: --dont-use-dragstr-priors
- id: dragen_378_concordance_mode
  type:
  - 'null'
  - boolean
  doc: 'Single argument for enabling the bulk of DRAGEN-GATK features including new developments for concordance
    against DRAGEN 3.7.8. NOTE: THIS WILL OVERWRITE PROVIDED ARGUMENT CHECK TOOL INFO TO SEE WHICH ARGUMENTS
    ARE SET).'
  inputBinding:
    position: 1
    prefix: --dragen-378-concordance-mode
- id: dragen_pd_pair_hmm_implementation
  type:
  - 'null'
  - string
  doc: The DRAGEN PDPairHMM implementation to use for genotype likelihood calculations
  inputBinding:
    position: 1
    prefix: --dragen-pd-pair-hmm-implementation
- id: emit_ref_confidence
  type:
  - 'null'
  - string
  doc: Mode for emitting reference confidence scores (For Mutect2, this is a BETA feature)
  inputBinding:
    position: 1
    prefix: --emit-ref-confidence
- id: enable_all_annotations
  type:
  - 'null'
  - boolean
  doc: Use all possible annotations (not for the faint of heart)
  inputBinding:
    position: 1
    prefix: --enable-all-annotations
- id: expected_mismatch_rate_for_read_disqualification
  type:
  - 'null'
  - double
  doc: Error rate used to set expectation for post HMM read disqualification based on mismatches
  inputBinding:
    position: 1
    prefix: --expected-mismatch-rate-for-read-disqualification
- id: floor_blocks
  type:
  - 'null'
  - boolean
  doc: Output the band lower bound for each GQ block regardless of the data it represents
  inputBinding:
    position: 1
    prefix: --floor-blocks
- id: flow_assembly_collapse_partial_mode
  type:
  - 'null'
  - boolean
  doc: Collapse long flow-based hmers only up to difference in reference
  inputBinding:
    position: 1
    prefix: --flow-assembly-collapse-partial-mode
- id: flow_disallow_probs_larger_than_call
  type:
  - 'null'
  - boolean
  doc: Cap probabilities of error to 1 relative to base call
  inputBinding:
    position: 1
    prefix: --flow-disallow-probs-larger-than-call
- id: flow_fill_empty_bins_value
  type:
  - 'null'
  - double
  doc: Value to fill the zeros of the matrix with
  inputBinding:
    position: 1
    prefix: --flow-fill-empty-bins-value
- id: flow_filter_alleles
  type:
  - 'null'
  - boolean
  doc: pre-filter alleles before genotyping
  inputBinding:
    position: 1
    prefix: --flow-filter-alleles
- id: flow_filter_alleles_qual_threshold
  type:
  - 'null'
  - float
  doc: Threshold for prefiltering alleles on quality
  inputBinding:
    position: 1
    prefix: --flow-filter-alleles-qual-threshold
- id: flow_filter_alleles_sor_threshold
  type:
  - 'null'
  - float
  doc: Threshold for prefiltering alleles on SOR
  inputBinding:
    position: 1
    prefix: --flow-filter-alleles-sor-threshold
- id: flow_filter_lone_alleles
  type:
  - 'null'
  - boolean
  doc: Remove also lone alleles during allele filtering
  inputBinding:
    position: 1
    prefix: --flow-filter-lone-alleles
- id: flow_lump_probs
  type:
  - 'null'
  - boolean
  doc: Should all probabilities of insertion or deletion in the flow be combined together
  inputBinding:
    position: 1
    prefix: --flow-lump-probs
- id: flow_matrix_mods
  type:
  - 'null'
  - string
  doc: 'Modifications instructions to the read flow matrix. Format is src,dst{,src,dst}+. Example: 10,12,11,12
    - these instructions will copy element 10 into 11 and 12'
  inputBinding:
    position: 1
    prefix: --flow-matrix-mods
- id: flow_mode
  type:
  - 'null'
  - string
  doc: 'Single argument for enabling the bulk of Flow Based features. NOTE: THIS WILL OVERWRITE PROVIDED
    ARGUMENT CHECK TOOL INFO TO SEE WHICH ARGUMENTS ARE SET).'
  inputBinding:
    position: 1
    prefix: --flow-mode
- id: flow_probability_scaling_factor
  type:
  - 'null'
  - int
  doc: probability scaling factor for (phred=10) for probability quantization
  inputBinding:
    position: 1
    prefix: --flow-probability-scaling-factor
- id: flow_quantization_bins
  type:
  - 'null'
  - int
  doc: Number of bins for probability quantization
  inputBinding:
    position: 1
    prefix: --flow-quantization-bins
- id: flow_remove_non_single_base_pair_indels
  type:
  - 'null'
  - boolean
  doc: Should the probabilities of more then 1 indel be used
  inputBinding:
    position: 1
    prefix: --flow-remove-non-single-base-pair-indels
- id: flow_remove_one_zero_probs
  type:
  - 'null'
  - boolean
  doc: Remove probabilities of basecall of zero from non-zero genome
  inputBinding:
    position: 1
    prefix: --flow-remove-one-zero-probs
- id: flow_report_insertion_or_deletion
  type:
  - 'null'
  - boolean
  doc: Report either insertion or deletion, probability, not both
  inputBinding:
    position: 1
    prefix: --flow-report-insertion-or-deletion
- id: flow_retain_max_n_probs_base_format
  type:
  - 'null'
  - boolean
  doc: Keep only hmer/2 probabilities (like in base format)
  inputBinding:
    position: 1
    prefix: --flow-retain-max-n-probs-base-format
- id: flow_symmetric_indel_probs
  type:
  - 'null'
  - boolean
  doc: Should indel probabilities be symmetric in flow
  inputBinding:
    position: 1
    prefix: --flow-symmetric-indel-probs
- id: flow_use_t0_tag
  type:
  - 'null'
  - boolean
  doc: Use t0 tag if exists in the read to create flow matrix
  inputBinding:
    position: 1
    prefix: --flow-use-t0-tag
- id: force_active
  type:
  - 'null'
  - boolean
  doc: If provided, all regions will be marked as active
  inputBinding:
    position: 1
    prefix: --force-active
- id: force_call_filtered_alleles
  type:
  - 'null'
  - boolean
  doc: Force-call filtered alleles included in the resource specified by --alleles
  inputBinding:
    position: 1
    prefix: --force-call-filtered-alleles
- id: gvcf_gq_bands
  type:
  - 'null'
  - type: array
    items: int
    inputBinding:
      prefix: --gvcf-gq-bands
  doc: Exclusive upper bounds for reference confidence GQ bands (must be in [1, 100] and specified in
    increasing order)
  inputBinding:
    position: 1
- id: indel_size_to_eliminate_in_ref_model
  type:
  - 'null'
  - int
  doc: The size of an indel to check for in the reference model
  inputBinding:
    position: 1
    prefix: --indel-size-to-eliminate-in-ref-model
- id: keep_boundary_flows
  type:
  - 'null'
  - boolean
  doc: prevent spreading of boundary flows.
  inputBinding:
    position: 1
    prefix: --keep-boundary-flows
- id: kmer_size
  type:
  - 'null'
  - type: array
    items: int
    inputBinding:
      prefix: --kmer-size
  doc: Kmer size to use in the read threading assembler
  inputBinding:
    position: 1
- id: likelihood_calculation_engine
  type:
  - 'null'
  - string
  doc: What likelihood calculation engine to use to calculate the relative likelihood of reads vs haplotypes
  inputBinding:
    position: 1
    prefix: --likelihood-calculation-engine
- id: linked_de_bruijn_graph
  type:
  - 'null'
  - boolean
  doc: If enabled, the Assembly Engine will construct a Linked De Bruijn graph to recover better haplotypes
  inputBinding:
    position: 1
    prefix: --linked-de-bruijn-graph
- id: mapping_quality_threshold_for_genotyping
  type:
  - 'null'
  - int
  doc: 'Control the threshold for discounting reads from the genotyper due to mapping quality after the
    active region detection and assembly steps but before genotyping. NOTE: this is in contrast to the
    --minimum-mapping-quality argument which filters reads from all parts of the HaplotypeCaller. If you
    would like to call genotypes with a different threshold both arguments must be set.'
  inputBinding:
    position: 1
    prefix: --mapping-quality-threshold-for-genotyping
- id: max_alternate_alleles
  type:
  - 'null'
  - int
  doc: Maximum number of alternate alleles to genotype
  inputBinding:
    position: 1
    prefix: --max-alternate-alleles
- id: max_effective_depth_adjustment_for_frd
  type:
  - 'null'
  - int
  doc: Set the maximum depth to modify FRD adjustment to in the event of high depth sites (0 to disable)
  inputBinding:
    position: 1
    prefix: --max-effective-depth-adjustment-for-frd
- id: max_genotype_count
  type:
  - 'null'
  - int
  doc: Maximum number of genotypes to consider at any site
  inputBinding:
    position: 1
    prefix: --max-genotype-count
- id: max_mnp_distance
  type:
  - 'null'
  - int
  doc: Two or more phased substitutions separated by this distance or less are merged into MNPs.
  inputBinding:
    position: 1
    prefix: --max-mnp-distance
- id: max_num_haplotypes_in_population
  type:
  - 'null'
  - int
  doc: Maximum number of haplotypes to consider for your population
  inputBinding:
    position: 1
    prefix: --max-num-haplotypes-in-population
- id: max_prob_propagation_distance
  type:
  - 'null'
  - int
  doc: Upper limit on how many bases away probability mass can be moved around when calculating the boundaries
    between active and inactive assembly regions
  inputBinding:
    position: 1
    prefix: --max-prob-propagation-distance
- id: max_unpruned_variants
  type:
  - 'null'
  - int
  doc: Maximum number of variants in graph the adaptive pruner will allow
  inputBinding:
    position: 1
    prefix: --max-unpruned-variants
- id: min_dangling_branch_length
  type:
  - 'null'
  - int
  doc: Minimum length of a dangling branch to attempt recovery
  inputBinding:
    position: 1
    prefix: --min-dangling-branch-length
- id: min_pruning
  type:
  - 'null'
  - int
  doc: Minimum support to not prune paths in the graph
  inputBinding:
    position: 1
    prefix: --min-pruning
- id: native_dragen_pd_pair_avx_level
  type:
  - 'null'
  - string
  doc: AVX level instruction for gkl pd-pair-hmm impelmentation to use [SCALAR, AVX2, AVX512].
  inputBinding:
    position: 1
    prefix: --native-dragen-pd-pair-avx-level
- id: native_dragen_pd_pair_hmm_threads
  type:
  - 'null'
  - int
  doc: How many threads should a native DRAGEN pd-pairHMM implementation use
  inputBinding:
    position: 1
    prefix: --native-dragen-pd-pair-hmm-threads
- id: native_dragen_pd_pair_memory_limit
  type:
  - 'null'
  - int
  doc: 'Maximum limit for memory (in MB) to the GKL for internal uses. (NOTE: this memory is not manage
    by Java and is not subject to -Xmx limits)'
  inputBinding:
    position: 1
    prefix: --native-dragen-pd-pair-memory-limit
- id: native_dragen_pd_pair_open_mp_settings
  type:
  - 'null'
  - string
  doc: Whether to enable use of Open MP library within the GKL.
  inputBinding:
    position: 1
    prefix: --native-dragen-pd-pair-open-mp-settings
- id: num_pruning_samples
  type:
  - 'null'
  - int
  doc: Number of samples that must pass the minPruning threshold
  inputBinding:
    position: 1
    prefix: --num-pruning-samples
- id: pair_hmm_gap_continuation_penalty
  type:
  - 'null'
  - int
  doc: Flat gap continuation penalty for use in the Pair HMM
  inputBinding:
    position: 1
    prefix: --pair-hmm-gap-continuation-penalty
- id: pair_hmm_implementation
  type:
  - 'null'
  - string
  doc: The PairHMM implementation to use for genotype likelihood calculations
  inputBinding:
    position: 1
    prefix: --pair-hmm-implementation
- id: pair_hmm_results_file
  type:
  - 'null'
  - string
  doc: File to write exact pairHMM inputs/outputs to for debugging purposes
  inputBinding:
    position: 1
    prefix: --pair-hmm-results-file
- id: pcr_indel_model
  type:
  - 'null'
  - string
  doc: The PCR indel model to use
  inputBinding:
    position: 1
    prefix: --pcr-indel-model
- id: phred_scaled_global_read_mismapping_rate
  type:
  - 'null'
  - int
  doc: The global assumed mismapping rate for reads
  inputBinding:
    position: 1
    prefix: --phred-scaled-global-read-mismapping-rate
- id: pileup_detection
  type:
  - 'null'
  - boolean
  doc: If enabled, the variant caller will create pileup-based haplotypes in addition to the assembly-based
    haplotype generation.
  inputBinding:
    position: 1
    prefix: --pileup-detection
- id: pruning_lod_threshold
  type:
  - 'null'
  - double
  doc: Ln likelihood ratio threshold for adaptive pruning algorithm
  inputBinding:
    position: 1
    prefix: --pruning-lod-threshold
- id: pruning_seeding_lod_threshold
  type:
  - 'null'
  - double
  doc: Ln likelihood ratio threshold for seeding subgraph of good variation in adaptive pruning algorithm
  inputBinding:
    position: 1
    prefix: --pruning-seeding-lod-threshold
- id: recover_all_dangling_branches
  type:
  - 'null'
  - boolean
  doc: Recover all dangling branches
  inputBinding:
    position: 1
    prefix: --recover-all-dangling-branches
- id: reference_model_deletion_quality
  type:
  - 'null'
  - int
  doc: The quality of deletion in the reference model
  inputBinding:
    position: 1
    prefix: --reference-model-deletion-quality
- id: smith_waterman
  type:
  - 'null'
  - string
  doc: Which Smith-Waterman implementation to use, generally FASTEST_AVAILABLE is the right choice
  inputBinding:
    position: 1
    prefix: --smith-waterman
- id: smith_waterman_dangling_end_gap_extend_penalty
  type:
  - 'null'
  - int
  doc: Smith-Waterman gap-extend penalty for dangling-end recovery.
  inputBinding:
    position: 1
    prefix: --smith-waterman-dangling-end-gap-extend-penalty
- id: smith_waterman_dangling_end_gap_open_penalty
  type:
  - 'null'
  - int
  doc: Smith-Waterman gap-open penalty for dangling-end recovery.
  inputBinding:
    position: 1
    prefix: --smith-waterman-dangling-end-gap-open-penalty
- id: smith_waterman_dangling_end_match_value
  type:
  - 'null'
  - int
  doc: Smith-Waterman match value for dangling-end recovery.
  inputBinding:
    position: 1
    prefix: --smith-waterman-dangling-end-match-value
- id: smith_waterman_dangling_end_mismatch_penalty
  type:
  - 'null'
  - int
  doc: Smith-Waterman mismatch penalty for dangling-end recovery.
  inputBinding:
    position: 1
    prefix: --smith-waterman-dangling-end-mismatch-penalty
- id: smith_waterman_haplotype_to_reference_gap_extend_penalty
  type:
  - 'null'
  - int
  doc: Smith-Waterman gap-extend penalty for haplotype-to-reference alignment.
  inputBinding:
    position: 1
    prefix: --smith-waterman-haplotype-to-reference-gap-extend-penalty
- id: smith_waterman_haplotype_to_reference_gap_open_penalty
  type:
  - 'null'
  - int
  doc: Smith-Waterman gap-open penalty for haplotype-to-reference alignment.
  inputBinding:
    position: 1
    prefix: --smith-waterman-haplotype-to-reference-gap-open-penalty
- id: smith_waterman_haplotype_to_reference_match_value
  type:
  - 'null'
  - int
  doc: Smith-Waterman match value for haplotype-to-reference alignment.
  inputBinding:
    position: 1
    prefix: --smith-waterman-haplotype-to-reference-match-value
- id: smith_waterman_haplotype_to_reference_mismatch_penalty
  type:
  - 'null'
  - int
  doc: Smith-Waterman mismatch penalty for haplotype-to-reference alignment.
  inputBinding:
    position: 1
    prefix: --smith-waterman-haplotype-to-reference-mismatch-penalty
- id: smith_waterman_read_to_haplotype_gap_extend_penalty
  type:
  - 'null'
  - int
  doc: Smith-Waterman gap-extend penalty for read-to-haplotype alignment.
  inputBinding:
    position: 1
    prefix: --smith-waterman-read-to-haplotype-gap-extend-penalty
- id: smith_waterman_read_to_haplotype_gap_open_penalty
  type:
  - 'null'
  - int
  doc: Smith-Waterman gap-open penalty for read-to-haplotype alignment.
  inputBinding:
    position: 1
    prefix: --smith-waterman-read-to-haplotype-gap-open-penalty
- id: smith_waterman_read_to_haplotype_match_value
  type:
  - 'null'
  - int
  doc: Smith-Waterman match value for read-to-haplotype alignment.
  inputBinding:
    position: 1
    prefix: --smith-waterman-read-to-haplotype-match-value
- id: smith_waterman_read_to_haplotype_mismatch_penalty
  type:
  - 'null'
  - int
  doc: Smith-Waterman mismatch penalty for read-to-haplotype alignment.
  inputBinding:
    position: 1
    prefix: --smith-waterman-read-to-haplotype-mismatch-penalty
- id: soft_clip_low_quality_ends
  type:
  - 'null'
  - boolean
  doc: If enabled will preserve low-quality read ends as softclips (used for DRAGEN-GATK BQD genotyper
    model)
  inputBinding:
    position: 1
    prefix: --soft-clip-low-quality-ends
- id: transform_dragen_mapping_quality
  type:
  - 'null'
  - boolean
  doc: If enabled this argument will map DRAGEN aligner aligned reads with mapping quality <=250 to scale
    up to MQ 50
  inputBinding:
    position: 1
    prefix: --transform-dragen-mapping-quality
- id: use_filtered_reads_for_annotations
  type:
  - 'null'
  - boolean
  doc: Use the contamination-filtered read maps for the purposes of annotating variants
  inputBinding:
    position: 1
    prefix: --use-filtered-reads-for-annotations
- id: use_pdhmm_overlap_optimization
  type:
  - 'null'
  - boolean
  doc: 'PDHMM: An optimization to PDHMM, if set this will skip running PDHMM haplotype determination on
    reads that don''t overlap (within a few bases) of the determined allele in each haplotype. This substantially
    reduces the amount of read-haplotype comparisons at the expense of ignoring read realignment mapping
    artifacts. (Requires ''--use-pdhmm'' argument)'
  inputBinding:
    position: 1
    prefix: --use-pdhmm-overlap-optimization
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
- id: assembly_region_out_file
  type:
  - 'null'
  - File
  doc: Output the assembly region to this IGV formatted file
  outputBinding:
    glob: $(inputs.assembly_region_out)
- id: graph_output_file
  type:
  - 'null'
  - File
  doc: Write debug assembly graph information to this file
  outputBinding:
    glob: $(inputs.graph_output)
- id: bam_output_file
  type:
  - 'null'
  - File
  doc: File to which assembled haplotypes should be written
  outputBinding:
    glob: $(inputs.bam_output)
  secondaryFiles:
  - pattern: ^.bai
    required: false
  - pattern: .bai
    required: false
- id: pair_hmm_results_file_file
  type:
  - 'null'
  - File
  doc: File to write exact pairHMM inputs/outputs to for debugging purposes
  outputBinding:
    glob: $(inputs.pair_hmm_results_file)
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
