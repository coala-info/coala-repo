cwlVersion: v1.2
class: CommandLineTool
baseCommand: tvc
label: tvc
doc: "Torrent Variant Caller\n\nTool homepage: https://github.com/tronscan/tron-tvc-list"
inputs:
  - id: allow_complex
    type:
      - 'null'
      - string
    doc: allow generation of block substitution candidates
    default: off
    inputBinding:
      position: 101
      prefix: --allow-complex
  - id: allow_indels
    type:
      - 'null'
      - string
    doc: allow generation of indel candidates
    default: on
    inputBinding:
      position: 101
      prefix: --allow-indels
  - id: allow_mnps
    type:
      - 'null'
      - string
    doc: allow generation of mnp candidates
    default: on
    inputBinding:
      position: 101
      prefix: --allow-mnps
  - id: allow_snps
    type:
      - 'null'
      - string
    doc: allow generation of snp candidates
    default: on
    inputBinding:
      position: 101
      prefix: --allow-snps
  - id: data_quality_stringency
    type:
      - 'null'
      - float
    doc: minimum mean log-likelihood delta per read
    default: 4.0
    inputBinding:
      position: 101
      prefix: --data-quality-stringency
  - id: debug
    type:
      - 'null'
      - int
    doc: (0/1/2) display extra debug messages
    default: 0
    inputBinding:
      position: 101
      prefix: --debug
  - id: do_json_diagnostic
    type:
      - 'null'
      - string
    doc: (devel) dump internal state to json file (uses much more 
      time/memory/disk)
    default: off
    inputBinding:
      position: 101
      prefix: --do-json-diagnostic
  - id: do_minimal_diagnostic
    type:
      - 'null'
      - string
    doc: (devel) provide minimal read information for called variants
    default: off
    inputBinding:
      position: 101
      prefix: --do-minimal-diagnostic
  - id: do_mnp_realignment
    type:
      - 'null'
      - string
    doc: Realign reads in the vicinity of candidate mnp variants
    default: do-snp-realignment
    inputBinding:
      position: 101
      prefix: --do-mnp-realignment
  - id: do_snp_realignment
    type:
      - 'null'
      - string
    doc: Realign reads in the vicinity of candidate snp variants
    default: on
    inputBinding:
      position: 101
      prefix: --do-snp-realignment
  - id: downsample_to_coverage
    type:
      - 'null'
      - int
    doc: ??
    default: 2000
    inputBinding:
      position: 101
      prefix: --downsample-to-coverage
  - id: error_motifs
    type:
      - 'null'
      - File
    doc: table of systematic error motifs and their error rates
    inputBinding:
      position: 101
      prefix: --error-motifs
  - id: filter_deletion_predictions
    type:
      - 'null'
      - float
    doc: check post-evaluation systematic bias in deletions; a high value like 
      100 effectively turns off this filter
    default: 100.0
    inputBinding:
      position: 101
      prefix: --filter-deletion-predictions
  - id: filter_insertion_predictions
    type:
      - 'null'
      - float
    doc: check post-evaluation systematic bias in insertions; a high value like 
      100 effectively turns off this filter
    default: 100.0
    inputBinding:
      position: 101
      prefix: --filter-insertion-predictions
  - id: filter_unusual_predictions
    type:
      - 'null'
      - float
    doc: posterior log likelihood threshold for accepting bias estimate
    default: 0.3
    inputBinding:
      position: 101
      prefix: --filter-unusual-predictions
  - id: force_sample_name
    type:
      - 'null'
      - string
    doc: force all read groups to have this sample name
    default: off
    inputBinding:
      position: 101
      prefix: --force-sample-name
  - id: gen_min_alt_allele_freq
    type:
      - 'null'
      - float
    doc: minimum required alt allele frequency to generate a candidate
    default: 0.2
    inputBinding:
      position: 101
      prefix: --gen-min-alt-allele-freq
  - id: gen_min_coverage
    type:
      - 'null'
      - int
    doc: minimum required coverage to generate a candidate
    default: 6
    inputBinding:
      position: 101
      prefix: --gen-min-coverage
  - id: gen_min_indel_alt_allele_freq
    type:
      - 'null'
      - float
    doc: minimum required alt allele frequency to generate a homopolymer indel 
      candidate
    default: 0.2
    inputBinding:
      position: 101
      prefix: --gen-min-indel-alt-allele-freq
  - id: heal_snps
    type:
      - 'null'
      - string
    doc: suppress in/dels not participating in diploid variant genotypes if the 
      genotype contains a SNP or MNP
    default: on
    inputBinding:
      position: 101
      prefix: --heal-snps
  - id: heavy_tailed
    type:
      - 'null'
      - int
    doc: degrees of freedom in t-dist modeling signal residual heavy tail
    default: 3
    inputBinding:
      position: 101
      prefix: --heavy-tailed
  - id: hotspot_min_allele_freq
    type:
      - 'null'
      - float
    doc: minimum required alt allele frequency for non-reference hotspot variant
      call
    default: 0.2
    inputBinding:
      position: 101
      prefix: --hotspot-min-allele-freq
  - id: hotspot_min_cov_each_strand
    type:
      - 'null'
      - int
    doc: filter out hotspot variants with coverage on either strand below this
    default: snp-min-cov-each-strand
    inputBinding:
      position: 101
      prefix: --hotspot-min-cov-each-strand
  - id: hotspot_min_coverage
    type:
      - 'null'
      - int
    doc: filter out hotspot variants with total coverage below this
    default: 6
    inputBinding:
      position: 101
      prefix: --hotspot-min-coverage
  - id: hotspot_min_variant_score
    type:
      - 'null'
      - float
    doc: filter out hotspot variants with QUAL score below this
    default: snp-min-variant-score
    inputBinding:
      position: 101
      prefix: --hotspot-min-variant-score
  - id: hotspot_strand_bias
    type:
      - 'null'
      - float
    doc: filter out hotspot variants with strand bias above this given pval < 
      hotspot-strand-bias-pval
    default: 0.95
    inputBinding:
      position: 101
      prefix: --hotspot-strand-bias
  - id: hotspot_strand_bias_pval
    type:
      - 'null'
      - float
    doc: filter out hotspot variants with pval below this given strand bias > 
      hotspot-strand-bias
    default: 1.0
    inputBinding:
      position: 101
      prefix: --hotspot-strand-bias-pval
  - id: hp_max_length
    type:
      - 'null'
      - int
    doc: filter out indels in homopolymers above this
    default: 8
    inputBinding:
      position: 101
      prefix: --hp-max-length
  - id: indel_as_hpindel
    type:
      - 'null'
      - string
    doc: apply indel filters to non HP indels
    default: off
    inputBinding:
      position: 101
      prefix: --indel-as-hpindel
  - id: indel_min_allele_freq
    type:
      - 'null'
      - float
    doc: minimum required alt allele frequency for non-reference indel call
    default: 0.2
    inputBinding:
      position: 101
      prefix: --indel-min-allele-freq
  - id: indel_min_cov_each_strand
    type:
      - 'null'
      - int
    doc: filter out indels with coverage on either strand below this
    default: 1
    inputBinding:
      position: 101
      prefix: --indel-min-cov-each-strand
  - id: indel_min_coverage
    type:
      - 'null'
      - int
    doc: filter out indels with total coverage below this
    default: 30
    inputBinding:
      position: 101
      prefix: --indel-min-coverage
  - id: indel_min_variant_score
    type:
      - 'null'
      - float
    doc: filter out indels with QUAL score below this
    default: 10.0
    inputBinding:
      position: 101
      prefix: --indel-min-variant-score
  - id: indel_strand_bias
    type:
      - 'null'
      - float
    doc: filter out indels with strand bias above this given pval < 
      indel-strand-bias-pval
    default: 0.95
    inputBinding:
      position: 101
      prefix: --indel-strand-bias
  - id: indel_strand_bias_pval
    type:
      - 'null'
      - float
    doc: filter out indels with pval below this given strand bias > 
      indel-strand-bias
    default: 1.0
    inputBinding:
      position: 101
      prefix: --indel-strand-bias-pval
  - id: input_bam
    type: File
    doc: bam file with mapped reads
    inputBinding:
      position: 101
      prefix: --input-bam
  - id: input_vcf
    type:
      - 'null'
      - File
    doc: vcf.gz file (+.tbi) with additional candidate variant locations and 
      alleles
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: k_zero
    type:
      - 'null'
      - float
    doc: variance increase for adding systematic bias
    default: 3.0
    inputBinding:
      position: 101
      prefix: --k-zero
  - id: max_complex_gap
    type:
      - 'null'
      - int
    doc: maximum number of reference alleles between two alternate alleles to 
      allow merging of the alternate alleles
    default: 1
    inputBinding:
      position: 101
      prefix: --max-complex-gap
  - id: max_detail_level
    type:
      - 'null'
      - int
    doc: number of evaluated frequencies for a given hypothesis, reduce for very
      high coverage, set to zero to disable this option
    default: 0
    inputBinding:
      position: 101
      prefix: --max-detail-level
  - id: max_flows_to_test
    type:
      - 'null'
      - int
    doc: maximum number of scoring flows
    default: 10
    inputBinding:
      position: 101
      prefix: --max-flows-to-test
  - id: min_delta_for_flow
    type:
      - 'null'
      - float
    doc: minimum prediction delta for scoring flows
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min-delta-for-flow
  - id: min_mapping_qv
    type:
      - 'null'
      - int
    doc: do not use reads with mapping quality below this
    default: 4
    inputBinding:
      position: 101
      prefix: --min-mapping-qv
  - id: min_ratio_reads_non_sse_strand
    type:
      - 'null'
      - float
    doc: minimum required alt allele frequency for variants with error motifs on
      opposite strand
    default: 0.2
    inputBinding:
      position: 101
      prefix: --min-ratio-reads-non-sse-strand
  - id: minimum_sigma_prior
    type:
      - 'null'
      - float
    doc: prior variance per data point, constant
    default: 0.085
    inputBinding:
      position: 101
      prefix: --minimum-sigma-prior
  - id: mnp_min_allele_freq
    type:
      - 'null'
      - float
    doc: minimum required alt allele frequency for non-reference mnp calls
    default: snp-min-allele-freq
    inputBinding:
      position: 101
      prefix: --mnp-min-allele-freq
  - id: mnp_min_cov_each_strand
    type:
      - 'null'
      - int
    doc: filter out mnps with coverage on either strand below this
    default: snp-min-cov-each-strand
    inputBinding:
      position: 101
      prefix: --mnp-min-cov-each-strand
  - id: mnp_min_coverage
    type:
      - 'null'
      - int
    doc: filter out mnps with total coverage below this
    default: snp-min-coverage
    inputBinding:
      position: 101
      prefix: --mnp-min-coverage
  - id: mnp_min_variant_score
    type:
      - 'null'
      - float
    doc: filter out mnps with QUAL score below this
    default: snp-min-variant-score
    inputBinding:
      position: 101
      prefix: --mnp-min-variant-score
  - id: mnp_strand_bias
    type:
      - 'null'
      - float
    doc: filter out mnps with strand bias above this given pval < 
      mnp-strand-bias-pval
    default: snp-strand-bias
    inputBinding:
      position: 101
      prefix: --mnp-strand-bias
  - id: mnp_strand_bias_pval
    type:
      - 'null'
      - float
    doc: filter out mnps with pval below this given strand bias > 
      mnp-strand-bias
    default: snp-strand-bias-pval
    inputBinding:
      position: 101
      prefix: --mnp-strand-bias-pval
  - id: model_file
    type:
      - 'null'
      - File
    doc: HP recalibration model input file.
    inputBinding:
      position: 101
      prefix: --model-file
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of worker threads
    default: 2
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: num_variants_per_thread
    type:
      - 'null'
      - int
    doc: worker thread batch size
    default: 500
    inputBinding:
      position: 101
      prefix: --num-variants-per-thread
  - id: outlier_probability
    type:
      - 'null'
      - float
    doc: probability for outlier reads
    default: 0.01
    inputBinding:
      position: 101
      prefix: --outlier-probability
  - id: override_limits
    type:
      - 'null'
      - string
    doc: (devel) disable limit-check on input parameters
    default: off
    inputBinding:
      position: 101
      prefix: --override-limits
  - id: parameters_file
    type:
      - 'null'
      - File
    doc: json file with algorithm control parameters
    inputBinding:
      position: 101
      prefix: --parameters-file
  - id: position_bias
    type:
      - 'null'
      - float
    doc: filter out variants with position bias relative to soft clip ends in 
      reads > position-bias
    default: 0.75
    inputBinding:
      position: 101
      prefix: --position-bias
  - id: position_bias_pval
    type:
      - 'null'
      - float
    doc: filter out if position bias above position-bias given pval < 
      position-bias-pval
    default: 0.05
    inputBinding:
      position: 101
      prefix: --position-bias-pval
  - id: position_bias_ref_fraction
    type:
      - 'null'
      - float
    doc: skip position bias filter if (reference read count)/(reference + alt 
      allele read count) <= to this
    default: 0.05
    inputBinding:
      position: 101
      prefix: --position-bias-ref-fraction
  - id: postprocessed_bam
    type:
      - 'null'
      - File
    doc: (devel) save tvc-processed reads to an (unsorted) BAM file
    inputBinding:
      position: 101
      prefix: --postprocessed-bam
  - id: prediction_precision
    type:
      - 'null'
      - float
    doc: prior weight in bias estimator
    default: 30.0
    inputBinding:
      position: 101
      prefix: --prediction-precision
  - id: process_input_positions_only
    type:
      - 'null'
      - string
    doc: only generate candidates at locations from input-vcf
    default: off
    inputBinding:
      position: 101
      prefix: --process-input-positions-only
  - id: read_max_mismatch_fraction
    type:
      - 'null'
      - float
    doc: do not use reads with fraction of mismatches above this
    default: 1.0
    inputBinding:
      position: 101
      prefix: --read-max-mismatch-fraction
  - id: read_rejection_threshold
    type:
      - 'null'
      - float
    doc: filter variants where large numbers of reads are rejected as outliers
    default: 0.5
    inputBinding:
      position: 101
      prefix: --read-rejection-threshold
  - id: read_snp_limit
    type:
      - 'null'
      - int
    doc: do not use reads with number of snps above this
    default: 10
    inputBinding:
      position: 101
      prefix: --read-snp-limit
  - id: realignment_threshold
    type:
      - 'null'
      - float
    doc: Max. allowed fraction of reads where realignment causes an alignment 
      change
    default: 1.0
    inputBinding:
      position: 101
      prefix: --realignment-threshold
  - id: recal_model_hp_thres
    type:
      - 'null'
      - int
    doc: Lower threshold for HP recalibration.
    inputBinding:
      position: 101
      prefix: --recal-model-hp-thres
  - id: reference
    type: File
    doc: reference fasta file
    inputBinding:
      position: 101
      prefix: --reference
  - id: resolve_clipped_bases
    type:
      - 'null'
      - string
    doc: If 'true', the basecaller is used to solve soft clipped bases
    default: off
    inputBinding:
      position: 101
      prefix: --resolve-clipped-bases
  - id: sample_name
    type:
      - 'null'
      - string
    doc: sample for which variants are called (In case of input BAM files with 
      multiple samples)
    inputBinding:
      position: 101
      prefix: --sample-name
  - id: shift_likelihood_penalty
    type:
      - 'null'
      - float
    doc: penalize log-likelihood for solutions involving large systematic bias
    default: 0.3
    inputBinding:
      position: 101
      prefix: --shift-likelihood-penalty
  - id: sigma_prior_weight
    type:
      - 'null'
      - float
    doc: weight of prior estimate of variance compared to observations
    default: 1.0
    inputBinding:
      position: 101
      prefix: --sigma-prior-weight
  - id: slope_sigma_prior
    type:
      - 'null'
      - float
    doc: prior rate of increase of variance over minimum by signal
    default: 0.0084
    inputBinding:
      position: 101
      prefix: --slope-sigma-prior
  - id: snp_min_allele_freq
    type:
      - 'null'
      - float
    doc: minimum required alt allele frequency for non-reference snp calls
    default: 0.2
    inputBinding:
      position: 101
      prefix: --snp-min-allele-freq
  - id: snp_min_cov_each_strand
    type:
      - 'null'
      - int
    doc: filter out snps with coverage on either strand below this
    default: 0
    inputBinding:
      position: 101
      prefix: --snp-min-cov-each-strand
  - id: snp_min_coverage
    type:
      - 'null'
      - int
    doc: filter out snps with total coverage below this
    default: 6
    inputBinding:
      position: 101
      prefix: --snp-min-coverage
  - id: snp_min_variant_score
    type:
      - 'null'
      - float
    doc: filter out snps with QUAL score below this
    default: 10.0
    inputBinding:
      position: 101
      prefix: --snp-min-variant-score
  - id: snp_strand_bias
    type:
      - 'null'
      - float
    doc: filter out snps with strand bias above this given pval < 
      snp-strand-bias-pval
    default: 0.95
    inputBinding:
      position: 101
      prefix: --snp-strand-bias
  - id: snp_strand_bias_pval
    type:
      - 'null'
      - float
    doc: filter out snps with pval below this given strand bias > 
      snp-strand-bias
    default: 1.0
    inputBinding:
      position: 101
      prefix: --snp-strand-bias-pval
  - id: sse_prob_threshold
    type:
      - 'null'
      - float
    doc: filter out variants in motifs with error rates above this
    default: 0.2
    inputBinding:
      position: 101
      prefix: --sse-prob-threshold
  - id: sse_relative_safety_level
    type:
      - 'null'
      - float
    doc: dampen strand bias detection for SSE events for low coverage
    default: 0.025
    inputBinding:
      position: 101
      prefix: --sse-relative-safety-level
  - id: suppress_no_calls
    type:
      - 'null'
      - string
    doc: write filtered variants into the filtered variants vcf
    default: on
    inputBinding:
      position: 101
      prefix: --suppress-no-calls
  - id: suppress_nocall_genotypes
    type:
      - 'null'
      - string
    doc: do not report a genotype for filtered variants
    default: on
    inputBinding:
      position: 101
      prefix: --suppress-nocall-genotypes
  - id: suppress_recalibration
    type:
      - 'null'
      - string
    doc: Suppress homopolymer recalibration
    default: on
    inputBinding:
      position: 101
      prefix: --suppress-recalibration
  - id: suppress_reference_genotypes
    type:
      - 'null'
      - string
    doc: write reference calls into the filtered variants vcf
    default: on
    inputBinding:
      position: 101
      prefix: --suppress-reference-genotypes
  - id: target_file
    type:
      - 'null'
      - File
    doc: only process targets in this bed file
    inputBinding:
      position: 101
      prefix: --target-file
  - id: trim_ampliseq_primers
    type:
      - 'null'
      - string
    doc: match reads to targets and trim the ends that reach outside them
    default: off
    inputBinding:
      position: 101
      prefix: --trim-ampliseq-primers
  - id: tune_sbias
    type:
      - 'null'
      - float
    doc: dampen strand bias detection for low coverage
    default: 0.01
    inputBinding:
      position: 101
      prefix: --tune-sbias
  - id: use_best_n_alleles
    type:
      - 'null'
      - int
    doc: maximum number of snp alleles
    default: 2
    inputBinding:
      position: 101
      prefix: --use-best-n-alleles
  - id: use_input_allele_only
    type:
      - 'null'
      - string
    doc: only consider provided alleles for locations in input-vcf
    default: off
    inputBinding:
      position: 101
      prefix: --use-input-allele-only
  - id: use_position_bias
    type:
      - 'null'
      - string
    doc: enable the position bias filter
    default: off
    inputBinding:
      position: 101
      prefix: --use-position-bias
  - id: use_sse_basecaller
    type:
      - 'null'
      - string
    doc: Switch to use the vectorized version of the basecaller
    default: on
    inputBinding:
      position: 101
      prefix: --use-sse-basecaller
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: base directory for all output files
    outputBinding:
      glob: $(inputs.output_dir)
  - id: output_vcf
    type: File
    doc: vcf file with variant calling results
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tvc:v5.0.3git20151221.80e144edfsg-2-deb_cv1
