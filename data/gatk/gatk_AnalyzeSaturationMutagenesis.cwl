cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - AnalyzeSaturationMutagenesis
label: gatk_AnalyzeSaturationMutagenesis
doc: (Experimental) Processes reads from a MITESeq or other saturation 
  mutagenesis experiment. Main output is a tab-delimited text file 
  reportNamePrefix.variantCounts.
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: BAM/SAM/CRAM file containing reads
    inputBinding:
      position: 101
      prefix: --input
  - id: orf
    type: string
    doc: reference interval(s) of the ORF (1-based, inclusive), for example, 
      '134-180,214-238' (no spaces)
    inputBinding:
      position: 101
      prefix: --orf
  - id: output_file_prefix
    type: string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: --output-file-prefix
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
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
  - id: codon_translation
    type:
      - 'null'
      - string
    doc: codon translation (a string of 64 amino acid codes
    inputBinding:
      position: 101
      prefix: --codon-translation
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
  - id: dont_ignore_disjoint_pairs
    type:
      - 'null'
      - boolean
    doc: don't discard disjoint mates (i.e., combine variants from both reads)
    inputBinding:
      position: 101
      prefix: --dont-ignore-disjoint-pairs
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals to exclude from processing
    inputBinding:
      position: 101
      prefix: --exclude-intervals
  - id: find_large_deletions
    type:
      - 'null'
      - boolean
    doc: examine supplemental alignments to find large deletions
    inputBinding:
      position: 101
      prefix: --find-large-deletions
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
    doc: If non-zero, partitions VCF output into shards, each containing up to 
      the given number of records.
    inputBinding:
      position: 101
      prefix: --max-variants-per-shard
  - id: min_alt_length
    type:
      - 'null'
      - int
    doc: minimum length of supplemental alignment
    inputBinding:
      position: 101
      prefix: --min-alt-length
  - id: min_flanking_length
    type:
      - 'null'
      - int
    doc: minimum number of wt calls flanking variant
    inputBinding:
      position: 101
      prefix: --min-flanking-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum size of high-quality portion of read
    inputBinding:
      position: 101
      prefix: --min-length
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum map quality for read alignment. reads having alignments with 
      MAPQs less than this are treated as unmapped.
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: min_q
    type:
      - 'null'
      - int
    doc: minimum quality score for analyzed portion of read
    inputBinding:
      position: 101
      prefix: --min-q
  - id: min_variant_obs
    type:
      - 'null'
      - int
    doc: minimum number of observations of reported variants
    inputBinding:
      position: 101
      prefix: --min-variant-obs
  - id: paired_mode
    type:
      - 'null'
      - boolean
    doc: paired mode evaluation of variants (combine mates, when possible)
    inputBinding:
      position: 101
      prefix: --paired-mode
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
  - id: write_rejected_reads
    type:
      - 'null'
      - boolean
    doc: write BAM of rejected reads
    inputBinding:
      position: 101
      prefix: --write-rejected-reads
  - id: disable_tool_default_read_filters
    type:
      - 'null'
      - boolean
    doc: Disable all tool default read filters
    inputBinding:
      position: 101
      prefix: --disable-tool-default-read-filters
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
outputs:
  - id: output_output_file_prefix
    type: File[]
    doc: output file prefix
    outputBinding:
      glob: $(inputs.output_file_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
