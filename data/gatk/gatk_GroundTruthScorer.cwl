cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - GroundTruthScorer
label: gatk_GroundTruthScorer
doc: Ground Truth Scorer. EXPERIMENTAL FEATURE - USE AT YOUR OWN RISK
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: BAM/SAM/CRAM file containing reads
    inputBinding:
      position: 101
      prefix: --input
  - id: output_csv
    type: string
    doc: 'main CSV output file. supported file extensions: .csv, .csv.gz.'
    inputBinding:
      position: 101
      prefix: --output-csv
  - id: add_mean_call
    type:
      - 'null'
      - boolean
    doc: Add ReadMeanCall and ReadProbs columns to output
    inputBinding:
      position: 101
      prefix: --add-mean-call
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
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals to exclude from processing
    inputBinding:
      position: 101
      prefix: --exclude-intervals
  - id: features_file
    type:
      - 'null'
      - File
    doc: A VCF file containing features to be used as a use for filtering reads.
    inputBinding:
      position: 101
      prefix: --features-file
  - id: gatk_config_file
    type:
      - 'null'
      - File
    doc: A configuration file to use with the GATK.
    inputBinding:
      position: 101
      prefix: --gatk-config-file
  - id: genome_prior
    type:
      - 'null'
      - File
    doc: CSV input file containing genome-prior (one line per base with hmer 
      frequencies).
    inputBinding:
      position: 101
      prefix: --genome-prior
  - id: gt_no_output
    type:
      - 'null'
      - boolean
    doc: do not generate output records
    inputBinding:
      position: 101
      prefix: --gt-no-output
  - id: interval_padding
    type:
      - 'null'
      - int
    doc: Amount of padding (in bp) to add to each interval you are including.
    inputBinding:
      position: 101
      prefix: --interval-padding
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more genomic intervals over which to operate
    inputBinding:
      position: 101
      prefix: --intervals
  - id: native_pair_hmm_threads
    type:
      - 'null'
      - int
    doc: How many threads should a native pairHMM implementation use
    inputBinding:
      position: 101
      prefix: --native-pair-hmm-threads
  - id: normalized_score_threshold
    type:
      - 'null'
      - float
    doc: threshold for normalized score, below which reads are ignored
    inputBinding:
      position: 101
      prefix: --normalized-score-threshold
  - id: quality_percentiles
    type:
      - 'null'
      - string
    doc: list of quality percentiles, defaults to 10,25,50,75,90
    inputBinding:
      position: 101
      prefix: --quality-percentiles
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
  - id: report_file
    type: string
    doc: report output file.
    inputBinding:
      position: 101
      prefix: --report-file
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
  - id: pair_hmm_results_file
    type: string
    doc: File to write exact pairHMM inputs/outputs to for debugging purposes
    inputBinding:
      position: 101
      prefix: --pair-hmm-results-file
outputs:
  - id: output_output_csv
    type: File
    doc: 'main CSV output file. supported file extensions: .csv, .csv.gz.'
    outputBinding:
      glob: $(inputs.output_csv)
  - id: output_report_file
    type:
      - 'null'
      - File
    doc: report output file.
    outputBinding:
      glob: $(inputs.report_file)
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
