cwlVersion: v1.2
class: CommandLineTool
baseCommand: anise
label: anise_basil_anise
doc: "Assembly of Novel Inserted SEquence. ANISE will try to assemble the inserted
  sequences at the sites in IN.vcf and write the assembled sequences to OUT.vcf.\n
  \nTool homepage: https://github.com/seqan/anise_basil"
inputs:
  - id: assembly_site_fringe_radius
    type:
      - 'null'
      - int
    doc: Radius around insert site to cut for collecting clippings. Set to -1 to consider
      all records with >= 15 clipped bases. In range [-1..inf].
    default: -1
    inputBinding:
      position: 101
      prefix: --assembly-site-fringe-radius
  - id: assembly_site_window_radius
    type:
      - 'null'
      - int
    doc: Radius around insert site to cut for initial contigs. In range [100..inf].
    default: 1000
    inputBinding:
      position: 101
      prefix: --assembly-site-window-radius
  - id: auto_library_num_records
    type:
      - 'null'
      - int
    doc: Number of records to use for automatic library evaluation. Set to 0 to evaluate
      all. In range [0..inf].
    default: 100000
    inputBinding:
      position: 101
      prefix: --auto-library-num-records
  - id: clean_up_tmp_files
    type:
      - 'null'
      - boolean
    doc: Clean up temporary files.
    inputBinding:
      position: 101
      prefix: --clean-up-tmp-files
  - id: consensus_min_base_support
    type:
      - 'null'
      - int
    doc: Minimal base support for non-N call in consensus calling.
    default: 2
    inputBinding:
      position: 101
      prefix: --consensus-min-base-support
  - id: consensus_min_contig_length_rate
    type:
      - 'null'
      - int
    doc: Minimal contig length in percent of average read length.
    default: 150
    inputBinding:
      position: 101
      prefix: --consensus-min-contig-length-rate
  - id: debug_site_id
    type:
      - 'null'
      - int
    doc: Debug site ID (-1 to disable). In range [-1..inf].
    default: -1
    inputBinding:
      position: 101
      prefix: --debug-site-id
  - id: debug_step_no
    type:
      - 'null'
      - int
    doc: Debug step no (-1 to disable). In range [-1..inf].
    default: -1
    inputBinding:
      position: 101
      prefix: --debug-step_no
  - id: fragment_default_orientation
    type:
      - 'null'
      - string
    doc: Default orientation. One of F+, F-, R+, and R-.
    default: R+
    inputBinding:
      position: 101
      prefix: --fragment-default-orientation
  - id: fragment_size_factor
    type:
      - 'null'
      - float
    doc: Factor to multiple fragment size stddev with to get allowed error. In range
      [0..inf].
    default: 8.0
    inputBinding:
      position: 101
      prefix: --fragment-size-factor
  - id: fragment_size_median
    type:
      - 'null'
      - int
    doc: Median fragment size. In range [0..inf].
    default: 250
    inputBinding:
      position: 101
      prefix: --fragment-size-median
  - id: fragment_size_std_dev
    type:
      - 'null'
      - int
    doc: Fragment size standard deviation. In range [0..inf].
    default: 30
    inputBinding:
      position: 101
      prefix: --fragment-size-std-dev
  - id: input_mapping
    type: File
    doc: 'Input SAM/BAM mapping file. Valid filetypes are: sam and bam.'
    inputBinding:
      position: 101
      prefix: --input-mapping
  - id: input_reference
    type: File
    doc: 'Input FASTA file with reference. Valid filetypes are: fa and fasta.'
    inputBinding:
      position: 101
      prefix: --input-reference
  - id: input_vcf
    type: File
    doc: 'Input VCF file with insert site candidates. Valid filetype is: vcf.'
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: max_reads_factor
    type:
      - 'null'
      - float
    doc: Factor to use for the maximal read computation. In range [1..inf].
    default: 2.0
    inputBinding:
      position: 101
      prefix: --max-reads-factor
  - id: msa_score_gap_extend
    type:
      - 'null'
      - int
    doc: PW gap extension score in MSA.
    default: -9
    inputBinding:
      position: 101
      prefix: --msa-score-gap-extend
  - id: msa_score_gap_open
    type:
      - 'null'
      - int
    doc: PW gap open score in MSA.
    default: -4
    inputBinding:
      position: 101
      prefix: --msa-score-gap-open
  - id: msa_score_match
    type:
      - 'null'
      - int
    doc: PW match score in MSA.
    default: 2
    inputBinding:
      position: 101
      prefix: --msa-score-match
  - id: msa_score_mismatch
    type:
      - 'null'
      - int
    doc: PW mismatch score in MSA.
    default: -6
    inputBinding:
      position: 101
      prefix: --msa-score-mismatch
  - id: no_auto_tuning
    type:
      - 'null'
      - boolean
    doc: Disable auto-tuning.
    inputBinding:
      position: 101
      prefix: --no-auto-tuning
  - id: no_read_correction
    type:
      - 'null'
      - boolean
    doc: Whether or not to perform read correction
    inputBinding:
      position: 101
      prefix: --no-read-correction
  - id: no_realign_assembly
    type:
      - 'null'
      - boolean
    doc: Do not realign the reads after assembly.
    inputBinding:
      position: 101
      prefix: --no-realign-assembly
  - id: no_separate_repeats
    type:
      - 'null'
      - boolean
    doc: Dont' repeat separation algorithm after realignment.
    inputBinding:
      position: 101
      prefix: --no-separate-repeats
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. In range [1..inf].
    default: 1
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: overlapper_max_error_rate
    type:
      - 'null'
      - int
    doc: Overlapper maximum error rate in percent. In range [0..30].
    default: 5
    inputBinding:
      position: 101
      prefix: --overlapper-max-error-rate
  - id: overlapper_min_overlap_ratio
    type:
      - 'null'
      - int
    doc: Overlapper min overlap rate in percent of the longer read. In range [0..inf].
    default: 40
    inputBinding:
      position: 101
      prefix: --overlapper-min-overlap-ratio
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Set verbosity to a minimum.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: read_mapping_batch_size
    type:
      - 'null'
      - int
    doc: Batch size for read mapping. In range [1..inf].
    default: 10000
    inputBinding:
      position: 101
      prefix: --read-mapping-batch-size
  - id: read_mapping_error_rate
    type:
      - 'null'
      - int
    doc: Error rate of internal read mapping step in percent. In range [0..20].
    default: 5
    inputBinding:
      position: 101
      prefix: --read-mapping-error-rate
  - id: realignment_bandwidth
    type:
      - 'null'
      - int
    doc: The bandwidth to use in the realignment step. In range [0..inf].
    default: 40
    inputBinding:
      position: 101
      prefix: --realignment-bandwidth
  - id: realignment_border
    type:
      - 'null'
      - int
    doc: The border from the profile to extract around alignments. In range [0..inf].
    default: 30
    inputBinding:
      position: 101
      prefix: --realignment-border
  - id: recursion_max_steps
    type:
      - 'null'
      - int
    doc: Maximal recursion depth. 0 for infinity. In range [0..inf].
    default: 50
    inputBinding:
      position: 101
      prefix: --recursion-max-steps
  - id: repsep_max_random_correlation
    type:
      - 'null'
      - float
    doc: Repeat separation maximal random correlation. In range [0.0..1.0].
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --repsep-max-random-correlation
  - id: repsep_min_overlap
    type:
      - 'null'
      - int
    doc: Repeat separation minimal overlap value. In range [0..inf].
    default: 2
    inputBinding:
      position: 101
      prefix: --repsep-min-overlap
  - id: repsep_p_err
    type:
      - 'null'
      - float
    doc: Repeat separation per-base error for simple Tammi method. In range [0.0..1.0].
    default: 0.01
    inputBinding:
      position: 101
      prefix: --repsep-p-err
  - id: repsep_r_min
    type:
      - 'null'
      - int
    doc: Repeat separation r_min value. In range [0..inf].
    default: 100000
    inputBinding:
      position: 101
      prefix: --repsep-r-min
  - id: repsep_split_d_min
    type:
      - 'null'
      - boolean
    doc: Repeat separation split at d_min deviations.
    inputBinding:
      position: 101
      prefix: --repsep-split-d-min
  - id: repsep_start_compression_at
    type:
      - 'null'
      - int
    doc: Repeat separation start compression. In range [2..inf].
    default: 100
    inputBinding:
      position: 101
      prefix: --repsep-start-compression-at
  - id: repsep_tammi_method
    type:
      - 'null'
      - string
    doc: Variant of the Tammi method to use for repeat separation (simple or phred).
      One of phred and simple.
    default: simple
    inputBinding:
      position: 101
      prefix: --repsep-tammi-method
  - id: repsep_tau_min
    type:
      - 'null'
      - int
    doc: Repeat separation tau_min value. In range [0..inf].
    default: 100000
    inputBinding:
      position: 101
      prefix: --repsep-tau-min
  - id: stop_coverage
    type:
      - 'null'
      - int
    doc: If the length sum of all reads for a site divided by the length sum of its
      contigs is higher than this value before assembly then the site is deactivated.
      In range [0..inf].
    default: 100
    inputBinding:
      position: 101
      prefix: --stop-coverage
  - id: stop_initial_read_count
    type:
      - 'null'
      - int
    doc: If there are more than this number of reads for a site in the initial round
      then no assembly is performed. In range [0..inf].
    default: 4000
    inputBinding:
      position: 101
      prefix: --stop-initial-read-count
  - id: stop_read_count
    type:
      - 'null'
      - int
    doc: If there are more than this number of reads for a site in a later round then
      no assembly is performed. In range [0..inf].
    default: 30000
    inputBinding:
      position: 101
      prefix: --stop-read-count
  - id: stop_tex_read_count
    type:
      - 'null'
      - int
    doc: If there are more than this number of reads for a site in a later round then
      no triplet library extension is performed. In range [0..inf].
    default: 3000
    inputBinding:
      position: 101
      prefix: --stop-tex-read-count
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: Enable very verbose output.
    inputBinding:
      position: 101
      prefix: --very-verbose
outputs:
  - id: output_fasta
    type: File
    doc: 'Output FASTA with contigs Valid filetypes are: fa and fasta.'
    outputBinding:
      glob: $(inputs.output_fasta)
  - id: output_mapping
    type:
      - 'null'
      - File
    doc: 'Output SAM/BAM file with mapping fo reads to contigs in --output-fasta.
      Valid filetypes are: sam and bam.'
    outputBinding:
      glob: $(inputs.output_mapping)
  - id: output_debug_dir
    type:
      - 'null'
      - Directory
    doc: Directory for debug output. Leave empty for no such output.
    outputBinding:
      glob: $(inputs.output_debug_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anise_basil:1.2.0--py312hdcc493e_9
