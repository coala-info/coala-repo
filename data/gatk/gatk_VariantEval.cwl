cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - VariantEval
label: gatk_VariantEval
doc: Given a variant callset, it is common to calculate various quality control 
  metrics. These metrics include the number of raw or filtered SNP counts; ratio
  of transition mutations to transversions; concordance of a particular sample's
  calls to a genotyping chip; number of singletons per sample; etc. Furthermore,
  it is often useful to stratify these metrics by various criteria like 
  functional class (missense, nonsense, silent), whether the site is CpG site, 
  the amino acid degeneracy of the site, etc.
inputs:
  - id: eval
    type:
      type: array
      items: File
    secondaryFiles:
      - .tbi?
    doc: Input evaluation file(s)
    inputBinding:
      position: 101
      prefix: --eval
  - id: output
    type: string
    doc: File to which variants should be written
    inputBinding:
      position: 101
      prefix: --output
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
      - ^.dict
    doc: Reference sequence file
    inputBinding:
      position: 101
      prefix: --reference
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
  - id: ancestral_alignments
    type:
      - 'null'
      - File
    doc: Fasta file with ancestral alleles
    inputBinding:
      position: 101
      prefix: --ancestral-alignments
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
    doc: Size of the cloud-only prefetch buffer (in MB; 0 to disable). Defaults 
      to cloudPrefetchBuffer if unset.
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
  - id: comparison
    type:
      - 'null'
      - type: array
        items: File
    doc: Input comparison file(s)
    inputBinding:
      position: 101
      prefix: --comparison
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
  - id: dbsnp
    type:
      - 'null'
      - File
    secondaryFiles:
      - .tbi?
    doc: dbSNP file
    inputBinding:
      position: 101
      prefix: --dbsnp
  - id: disable_bam_index_caching
    type:
      - 'null'
      - boolean
    doc: If true, don't cache bam indexes, this will reduce memory requirements 
      but may harm performance if many intervals are specified.
    inputBinding:
      position: 101
      prefix: --disable-bam-index-caching
  - id: disable_sequence_dictionary_validation
    type:
      - 'null'
      - boolean
    doc: If specified, do not check the sequence dictionaries from our inputs 
      for compatibility.
    inputBinding:
      position: 101
      prefix: --disable-sequence-dictionary-validation
  - id: do_not_use_all_standard_modules
    type:
      - 'null'
      - boolean
    doc: Do not use the standard modules by default (instead, only those that 
      are specified with the -EV option)
    inputBinding:
      position: 101
      prefix: --do-not-use-all-standard-modules
  - id: do_not_use_all_standard_stratifications
    type:
      - 'null'
      - boolean
    doc: Do not use the standard stratification modules by default (instead, 
      only those that are specified with the -S option)
    inputBinding:
      position: 101
      prefix: --do-not-use-all-standard-stratifications
  - id: eval_module
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more specific eval modules to apply to the eval track(s)
    inputBinding:
      position: 101
      prefix: --eval-module
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
  - id: gold_standard
    type:
      - 'null'
      - File
    doc: Evaluations that count calls at sites of true variation (e.g., indel 
      calls) will use this argument as their gold standard for comparison
    inputBinding:
      position: 101
      prefix: --gold-standard
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM/SAM/CRAM file containing reads
    inputBinding:
      position: 101
      prefix: --input
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
  - id: keep_ac0
    type:
      - 'null'
      - boolean
    doc: If provided, modules that track polymorphic sites will not require that
      a site have AC > 0 when the input eval has genotypes
    inputBinding:
      position: 101
      prefix: --keep-ac0
  - id: known_cnvs
    type:
      - 'null'
      - File
    doc: File containing tribble-readable features describing a known list of 
      copy number variants
    inputBinding:
      position: 101
      prefix: --known-cnvs
  - id: known_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of feature bindings containing variant sites that should be 
      treated as known when splitting eval features into known and novel subsets
    inputBinding:
      position: 101
      prefix: --knownNames
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: Lenient processing of VCF files
    inputBinding:
      position: 101
      prefix: --lenient
  - id: list
    type:
      - 'null'
      - boolean
    doc: List the available eval modules and exit
    inputBinding:
      position: 101
      prefix: --list
  - id: max_variants_per_shard
    type:
      - 'null'
      - int
    doc: If non-zero, partitions VCF output into shards, each containing up to 
      the given number of records.
    inputBinding:
      position: 101
      prefix: --max-variants-per-shard
  - id: mendelian_violation_qual_threshold
    type:
      - 'null'
      - float
    doc: Minimum genotype QUAL score for each trio member required to accept a 
      site as a violation.
    inputBinding:
      position: 101
      prefix: --mendelian-violation-qual-threshold
  - id: merge_evals
    type:
      - 'null'
      - boolean
    doc: If provided, all -eval tracks will be merged into a single eval track
    inputBinding:
      position: 101
      prefix: --merge-evals
  - id: min_phase_quality
    type:
      - 'null'
      - float
    doc: Minimum phasing quality
    inputBinding:
      position: 101
      prefix: --min-phase-quality
  - id: pedigree
    type:
      - 'null'
      - File
    doc: Pedigree file for determining the population "founders"
    inputBinding:
      position: 101
      prefix: --pedigree
  - id: pedigree_validation_type
    type:
      - 'null'
      - string
    doc: The strictness for validating the pedigree. Can be either STRICT or 
      SILENT.
    inputBinding:
      position: 101
      prefix: --pedigreeValidationType
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
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
  - id: require_strict_allele_match
    type:
      - 'null'
      - boolean
    doc: If provided only comp and eval tracks with exactly matching reference 
      and alternate alleles will be counted as overlapping
    inputBinding:
      position: 101
      prefix: --require-strict-allele-match
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Derive eval and comp contexts using only these sample genotypes
    inputBinding:
      position: 101
      prefix: --sample
  - id: sample_ploidy
    type:
      - 'null'
      - int
    doc: Per-sample ploidy (number of chromosomes per sample)
    inputBinding:
      position: 101
      prefix: --sample-ploidy
  - id: seconds_between_progress_updates
    type:
      - 'null'
      - float
    doc: Output traversal statistics every time this many seconds elapse
    inputBinding:
      position: 101
      prefix: --seconds-between-progress-updates
  - id: select_exps
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more stratifications to use when evaluating the data
    inputBinding:
      position: 101
      prefix: --selectExps
  - id: select_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Names to use for the list of stratifications (must be a 1-to-1 mapping)
    inputBinding:
      position: 101
      prefix: --selectNames
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
  - id: strat_intervals
    type:
      - 'null'
      - File
    doc: File containing tribble-readable features for the 
      IntervalStratificiation
    inputBinding:
      position: 101
      prefix: --strat-intervals
  - id: stratification_module
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more specific stratification modules to apply to the eval 
      track(s)
    inputBinding:
      position: 101
      prefix: --stratification-module
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
  - id: combine_variants_distance
    type:
      - 'null'
      - int
    doc: Maximum distance for variants to be grouped together
    inputBinding:
      position: 101
      prefix: --combine-variants-distance
  - id: ignore_variants_starting_outside_interval
    type:
      - 'null'
      - boolean
    doc: Restrict variant output to sites that start within provided intervals
    inputBinding:
      position: 101
      prefix: --ignore-variants-starting-outside-interval
  - id: max_distance
    type:
      - 'null'
      - int
    doc: Maximum distance for variants to be grouped together
    inputBinding:
      position: 101
      prefix: --max-distance
  - id: ref_padding
    type:
      - 'null'
      - int
    doc: Number of bases on either side to expand spanning reference window
    inputBinding:
      position: 101
      prefix: --ref-padding
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
  - id: variant_output_filtering
    type:
      - 'null'
      - string
    doc: Restrict the output variants to ones that match the specified intervals
      according to the specified matching mode.
    inputBinding:
      position: 101
      prefix: --variant-output-filtering
outputs:
  - id: output_output
    type: File
    doc: File to which variants should be written
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
