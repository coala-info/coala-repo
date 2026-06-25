cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - GroundTruthReadsBuilder
label: gatk_GroundTruthReadsBuilder
doc: Ground Truth Reads Builder. EXPERIMENTAL FEATURE - USE AT YOUR OWN RISK. 
  This tool builds ground truth reads by comparing input reads against maternal 
  and paternal reference sequences.
inputs:
  - id: ancestral_translators_base_path
    type: string
    doc: base path for ancestral translation ancestral.contig.csv files
    inputBinding:
      position: 101
      prefix: --ancestral-translators-base-path
  - id: input
    type:
      type: array
      items: File
    doc: BAM/SAM/CRAM file containing reads
    inputBinding:
      position: 101
      prefix: --input
  - id: maternal_ref
    type:
      - 'null'
      - File
    doc: maternal reference file
    inputBinding:
      position: 101
      prefix: --maternal-ref
  - id: output_csv
    type: string
    doc: 'main CSV output file. the file containing maternal/parental maternal and
      paternal haplotype sequences and scores (and many more columns). supported file
      extensions: .csv, .csv.gz.'
    inputBinding:
      position: 101
      prefix: --output-csv
  - id: paternal_ref
    type:
      - 'null'
      - File
    doc: paternal reference file
    inputBinding:
      position: 101
      prefix: --paternal-ref
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
  - id: append_sequence
    type:
      - 'null'
      - string
    doc: Sequence to append (adapter)
    inputBinding:
      position: 101
      prefix: --append-sequence
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
  - id: discard_non_polyt_softclipped_reads
    type:
      - 'null'
      - boolean
    doc: Discard reads which are softclipped, unless the softclip is polyT, 
      defaults to true
    inputBinding:
      position: 101
      prefix: --discard-non-polyt-softclipped-reads
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
  - id: false_snp_compensation
    type:
      - 'null'
      - boolean
    doc: skip haplotype bases until same base as read starts (false SNP 
      compensation)
    inputBinding:
      position: 101
      prefix: --false-snp-compensation
  - id: fill_softclipped_reads
    type:
      - 'null'
      - boolean
    doc: Softclipped reads should be filled from haplotype, otherwise (default) 
      filled with -83
    inputBinding:
      position: 101
      prefix: --fill-softclipped-reads
  - id: fill_trimmed_reads
    type:
      - 'null'
      - boolean
    doc: Reads with tm:Q or tm:Z should be filled from haplotype, otherwise 
      (default) filled with -80
    inputBinding:
      position: 101
      prefix: --fill-trimmed-reads
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
  - id: gt_no_output
    type:
      - 'null'
      - boolean
    doc: do not generate output records
    inputBinding:
      position: 101
      prefix: --gt-no-output
  - id: haplotype_output_padding_size
    type:
      - 'null'
      - int
    doc: Number of N to append to best haplotype on output
    inputBinding:
      position: 101
      prefix: --haplotype-output-padding-size
  - id: include_supp_align
    type:
      - 'null'
      - boolean
    doc: Include supplementary alignments
    inputBinding:
      position: 101
      prefix: --include-supp-align
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals over which to operate
    inputBinding:
      position: 101
      prefix: --intervals
  - id: max_output_reads
    type:
      - 'null'
      - int
    doc: maximal number of reads to output
    inputBinding:
      position: 101
      prefix: --max-output-reads
  - id: min_haplotype_score
    type:
      - 'null'
      - float
    doc: Minimal score (likelihood) on either haplotype
    inputBinding:
      position: 101
      prefix: --min-haplotype-score
  - id: native_pair_hmm_threads
    type:
      - 'null'
      - int
    doc: How many threads should a native pairHMM implementation use
    inputBinding:
      position: 101
      prefix: --native-pair-hmm-threads
  - id: prepend_sequence
    type:
      - 'null'
      - string
    doc: Sequence to prepend (barcode)
    inputBinding:
      position: 101
      prefix: --prepend-sequence
  - id: read_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Read filters to be applied before analysis
    inputBinding:
      position: 101
      prefix: --read-filter
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
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    doc: Use the given sequence dictionary as the master/canonical sequence 
      dictionary. Must be a .dict file.
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temp directory to use.
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: output_output_csv
    type: File
    doc: 'main CSV output file. the file containing maternal/parental maternal and
      paternal haplotype sequences and scores (and many more columns). supported file
      extensions: .csv, .csv.gz.'
    outputBinding:
      glob: $(inputs.output_csv)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:latest
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
