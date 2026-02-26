cwlVersion: v1.2
class: CommandLineTool
baseCommand: freebayes
label: freebayes
doc: "Bayesian haplotype-based polymorphism discovery.\n\nTool homepage: https://github.com/freebayes/freebayes"
inputs:
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM files to be analyzed
    inputBinding:
      position: 1
  - id: add_bam_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Add FILE to the set of BAM files to be analyzed.
    inputBinding:
      position: 102
      prefix: --bam
  - id: allele_balance_priors_off
    type:
      - 'null'
      - boolean
    doc: Disable use of aggregate probability of observation balance between 
      alleles as a component of the priors.
    inputBinding:
      position: 102
      prefix: --allele-balance-priors-off
  - id: bam_list
    type:
      - 'null'
      - File
    doc: A file containing a list of BAM files to be analyzed.
    inputBinding:
      position: 102
      prefix: --bam-list
  - id: base_quality_cap
    type:
      - 'null'
      - int
    doc: Limit estimated observation quality by capping base quality at Q.
    inputBinding:
      position: 102
      prefix: --base-quality-cap
  - id: binomial_obs_priors_off
    type:
      - 'null'
      - boolean
    doc: Disable incorporation of prior expectations about observations. Uses 
      read placement probability, strand balance probability, and read position 
      (5'-3') probability.
    inputBinding:
      position: 102
      prefix: --binomial-obs-priors-off
  - id: cnv_map
    type:
      - 'null'
      - File
    doc: 'Read a copy number map from the BED file FILE, which has either a sample-level
      ploidy: sample_name copy_number or a region-specific format: seq_name start
      end sample_name copy_number ... for each region in each sample which does not
      have the default copy number as set by --ploidy. These fields can be delimited
      by space or tab.'
    inputBinding:
      position: 102
      prefix: --cnv-map
  - id: contamination_estimates
    type:
      - 'null'
      - File
    doc: "A file containing per-sample estimates of contamination, such as those generated
      by VerifyBamID. The format should be: sample p(read=R|genotype=AR) p(read=A|genotype=AA)
      Sample '*' can be used to set default contamination estimates."
    inputBinding:
      position: 102
      prefix: --contamination-estimates
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debugging output.
    inputBinding:
      position: 102
      prefix: --debug
  - id: debug_verbose
    type:
      - 'null'
      - boolean
    doc: Print more verbose debugging output (requires "make DEBUG")
    inputBinding:
      position: 102
      prefix: --debug
  - id: dont_left_align_indels
    type:
      - 'null'
      - boolean
    doc: Turn off left-alignment of indels, which is enabled by default.
    inputBinding:
      position: 102
      prefix: --dont-left-align-indels
  - id: exclude_unobserved_genotypes
    type:
      - 'null'
      - boolean
    doc: Skip sample genotypings for which the sample has no supporting reads.
    inputBinding:
      position: 102
      prefix: --exclude-unobserved-genotypes
  - id: genotype_qualities
    type:
      - 'null'
      - boolean
    doc: Calculate the marginal probability of genotypes and report as GQ in 
      each sample field in the VCF output.
    inputBinding:
      position: 102
      prefix: --genotype-qualities
  - id: genotype_variant_threshold
    type:
      - 'null'
      - string
    doc: 'Limit posterior integration to samples where the second-best genotype likelihood
      is no more than log(N) from the highest genotype likelihood for the sample.
      default: ~unbounded'
    inputBinding:
      position: 102
      prefix: --genotype-variant-threshold
  - id: genotyping_max_banddepth
    type:
      - 'null'
      - int
    doc: 'Integrate no deeper than the Nth best genotype by likelihood when genotyping.
      default: 6.'
    default: 6
    inputBinding:
      position: 102
      prefix: --genotyping-max-banddepth
  - id: genotyping_max_iterations
    type:
      - 'null'
      - int
    doc: 'Iterate no more than N times during genotyping step. default: 1000.'
    default: 1000
    inputBinding:
      position: 102
      prefix: --genotyping-max-iterations
  - id: gvcf
    type:
      - 'null'
      - boolean
    doc: Write gVCF output, which indicates coverage in uncalled regions.
    inputBinding:
      position: 102
      prefix: --gvcf
  - id: gvcf_chunk
    type:
      - 'null'
      - int
    doc: When writing gVCF output emit a record for every NUM bases.
    inputBinding:
      position: 102
      prefix: --gvcf-chunk
  - id: gvcf_dont_use_chunk
    type:
      - 'null'
      - boolean
    doc: When writing the gVCF output emit a record for all bases if set to 
      "true" , will also route an int to --gvcf-chunk similar to --output-mode 
      EMIT_ALL_SITES from GATK
    inputBinding:
      position: 102
      prefix: --gvcf-dont-use-chunk
  - id: haplotype_basis_alleles
    type:
      - 'null'
      - File
    doc: When specified, only variant alleles provided in this input VCF will be
      used for the construction of complex or haplotype alleles.
    inputBinding:
      position: 102
      prefix: --haplotype-basis-alleles
  - id: haplotype_length
    type:
      - 'null'
      - int
    doc: 'Allow haplotype calls with contiguous embedded matches of up to this length.
      Set N=-1 to disable clumping. (default: 3)'
    default: 3
    inputBinding:
      position: 102
      prefix: --haplotype-length
  - id: harmonic_indel_quality
    type:
      - 'null'
      - boolean
    doc: Use a weighted sum of base qualities around an indel, scaled by the 
      distance from the indel. By default use a minimum BQ in flanking sequence.
    inputBinding:
      position: 102
      prefix: --harmonic-indel-quality
  - id: hwe_priors_off
    type:
      - 'null'
      - boolean
    doc: Disable estimation of the probability of the combination arising under 
      HWE given the allele frequency as estimated by observation frequency.
    inputBinding:
      position: 102
      prefix: --hwe-priors-off
  - id: legacy_gls
    type:
      - 'null'
      - boolean
    doc: Use legacy (polybayes equivalent) genotype likelihood calculations
    inputBinding:
      position: 102
      prefix: --legacy-gls
  - id: limit_coverage
    type:
      - 'null'
      - int
    doc: 'Downsample per-sample coverage to this level if greater than this coverage.
      default: no limit'
    inputBinding:
      position: 102
      prefix: --limit-coverage
  - id: max_complex_gap
    type:
      - 'null'
      - int
    doc: 'Allow haplotype calls with contiguous embedded matches of up to this length.
      Set N=-1 to disable clumping. (default: 3)'
    default: 3
    inputBinding:
      position: 102
      prefix: --max-complex-gap
  - id: min_alternate_count
    type:
      - 'null'
      - int
    doc: 'Require at least this count of observations supporting an alternate allele
      within a single individual in order to evaluate the position. default: 2'
    default: 2
    inputBinding:
      position: 102
      prefix: --min-alternate-count
  - id: min_alternate_fraction
    type:
      - 'null'
      - float
    doc: 'Require at least this fraction of observations supporting an alternate allele
      within a single individual in the in order to evaluate the position. default:
      0.05'
    default: 0.05
    inputBinding:
      position: 102
      prefix: --min-alternate-fraction
  - id: min_alternate_qsum
    type:
      - 'null'
      - int
    doc: 'Require at least this sum of quality of observations supporting an alternate
      allele within a single individual in order to evaluate the position. default:
      0'
    default: 0
    inputBinding:
      position: 102
      prefix: --min-alternate-qsum
  - id: min_alternate_total
    type:
      - 'null'
      - int
    doc: 'Require at least this count of observations supporting an alternate allele
      within the total population in order to use the allele in analysis. default:
      1'
    default: 1
    inputBinding:
      position: 102
      prefix: --min-alternate-total
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: 'Exclude alleles from analysis if their supporting base quality is less than
      Q. default: 0'
    default: 0
    inputBinding:
      position: 102
      prefix: --min-base-quality
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: 'Require at least this coverage to process a site. default: 0'
    default: 0
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: 'Exclude alignments from analysis if they have a mapping quality less than
      Q. default: 1'
    default: 1
    inputBinding:
      position: 102
      prefix: --min-mapping-quality
  - id: min_repeat_entropy
    type:
      - 'null'
      - float
    doc: 'To detect interrupted repeats, build across sequence until it has entropy
      > N bits per bp. Set to 0 to turn off. (default: 1)'
    default: 0.0
    inputBinding:
      position: 102
      prefix: --min-repeat-entropy
  - id: min_repeat_size
    type:
      - 'null'
      - int
    doc: 'When assembling observations across repeats, require the total repeat length
      at least this many bp. (default: 5)'
    default: 5
    inputBinding:
      position: 102
      prefix: --min-repeat-size
  - id: min_supporting_allele_qsum
    type:
      - 'null'
      - int
    doc: 'Consider any allele in which the sum of qualities of supporting observations
      is at least Q. default: 0'
    default: 0
    inputBinding:
      position: 102
      prefix: --min-supporting-allele-qsum
  - id: min_supporting_mapping_qsum
    type:
      - 'null'
      - int
    doc: 'Consider any allele in which and the sum of mapping qualities of supporting
      reads is at least Q. default: 0'
    default: 0
    inputBinding:
      position: 102
      prefix: --min-supporting-mapping-qsum
  - id: mismatch_base_quality_threshold
    type:
      - 'null'
      - int
    doc: 'Count mismatches toward --read-mismatch-limit if the base quality of the
      mismatch is >= Q. default: 10'
    default: 10
    inputBinding:
      position: 102
      prefix: --mismatch-base-quality-threshold
  - id: no_partial_observations
    type:
      - 'null'
      - boolean
    doc: Exclude observations which do not fully span the dynamically-determined
      detection window. (default, use all observations, dividing partial support
      across matching haplotypes when generating haplotypes.)
    inputBinding:
      position: 102
      prefix: --no-partial-observations
  - id: no_population_priors
    type:
      - 'null'
      - boolean
    doc: Equivalent to --pooled-discrete --hwe-priors-off and removal of Ewens 
      Sampling Formula component of priors.
    inputBinding:
      position: 102
      prefix: --no-population-priors
  - id: observation_bias
    type:
      - 'null'
      - File
    doc: Read length-dependent allele observation biases from FILE. The format 
      is [length] [alignment efficiency relative to reference] where the 
      efficiency is 1 if there is no relative observation bias.
    inputBinding:
      position: 102
      prefix: --observation-bias
  - id: only_use_input_alleles
    type:
      - 'null'
      - boolean
    doc: Only provide variant calls and genotype likelihoods for sites and 
      alleles which are provided in the VCF input, and provide output in the VCF
      for all input alleles, not just those which have support in the data.
    inputBinding:
      position: 102
      prefix: --only-use-input-alleles
  - id: ploidy
    type:
      - 'null'
      - int
    doc: 'Sets the default ploidy for the analysis to N. default: 2'
    default: 2
    inputBinding:
      position: 102
      prefix: --ploidy
  - id: pooled_continuous
    type:
      - 'null'
      - boolean
    doc: Output all alleles which pass input filters, regardles of genotyping 
      outcome or model.
    inputBinding:
      position: 102
      prefix: --pooled-continuous
  - id: pooled_discrete
    type:
      - 'null'
      - boolean
    doc: Assume that samples result from pooled sequencing. Model pooled samples
      using discrete genotypes across pools. When using this flag, set --ploidy 
      to the number of alleles in each sample or use the --cnv-map to define 
      per-sample ploidy.
    inputBinding:
      position: 102
      prefix: --pooled-discrete
  - id: populations
    type:
      - 'null'
      - File
    doc: Each line of FILE should list a sample and a population which it is 
      part of. The population-based bayesian inference model will then be 
      partitioned on the basis of the populations.
    inputBinding:
      position: 102
      prefix: --populations
  - id: posterior_integration_limits
    type:
      - 'null'
      - string
    doc: 'Integrate all genotype combinations in our posterior space which include
      no more than N samples with their Mth best data likelihood. default: 1,3.'
    default: 1,3
    inputBinding:
      position: 102
      prefix: --posterior-integration-limits
  - id: prob_contamination
    type:
      - 'null'
      - float
    doc: 'An estimate of contamination to use for all samples. default: 10e-9'
    default: '10e-9'
    inputBinding:
      position: 102
      prefix: --prob-contamination
  - id: pvar
    type:
      - 'null'
      - float
    doc: 'Report sites if the probability that there is a polymorphism at the site
      is greater than N. default: 0.0. Note that post-filtering is generally recommended
      over the use of this parameter.'
    default: 0.0
    inputBinding:
      position: 102
      prefix: --pvar
  - id: read_dependence_factor
    type:
      - 'null'
      - float
    doc: 'Incorporate non-independence of reads by scaling successive observations
      by this factor during data likelihood calculations. default: 0.9'
    default: 0.9
    inputBinding:
      position: 102
      prefix: --read-dependence-factor
  - id: read_indel_limit
    type:
      - 'null'
      - int
    doc: 'Exclude reads with more than N separate gaps. default: ~unbounded'
    inputBinding:
      position: 102
      prefix: --read-indel-limit
  - id: read_max_mismatch_fraction
    type:
      - 'null'
      - float
    doc: 'Exclude reads with more than N [0,1] fraction of mismatches where each mismatch
      has base quality >= mismatch-base-quality-threshold default: 1.0'
    default: 1.0
    inputBinding:
      position: 102
      prefix: --read-max-mismatch-fraction
  - id: read_mismatch_limit
    type:
      - 'null'
      - int
    doc: 'Exclude reads with more than N mismatches where each mismatch has base quality
      >= mismatch-base-quality-threshold. default: ~unbounded'
    inputBinding:
      position: 102
      prefix: --read-mismatch-limit
  - id: read_snp_limit
    type:
      - 'null'
      - int
    doc: 'Exclude reads with more than N base mismatches, ignoring gaps with quality
      >= mismatch-base-quality-threshold. default: ~unbounded'
    inputBinding:
      position: 102
      prefix: --read-snp-limit
  - id: reference_fasta
    type: File
    doc: Use FILE as the reference sequence for analysis. An index file 
      (FILE.fai) will be created if none exists. If neither --targets nor 
      --region are specified, FreeBayes will analyze every position in this 
      reference.
    inputBinding:
      position: 102
      prefix: --fasta-reference
  - id: reference_quality
    type:
      - 'null'
      - string
    doc: 'Assign mapping quality of MQ to the reference allele at each site and base
      quality of BQ. default: 100,60'
    default: 100,60
    inputBinding:
      position: 102
      prefix: --reference-quality
  - id: region
    type:
      - 'null'
      - string
    doc: Limit analysis to the specified region, 0-base coordinates, 
      end_position not included (same as BED format). Either '-' or '..' maybe 
      used as a separator.
    inputBinding:
      position: 102
      prefix: --region
  - id: report_all_haplotype_alleles
    type:
      - 'null'
      - boolean
    doc: At sites where genotypes are made over haplotype alleles, provide 
      information about all alleles in output, not only those which are called.
    inputBinding:
      position: 102
      prefix: --report-all-haplotype-alleles
  - id: report_genotype_likelihood_max
    type:
      - 'null'
      - boolean
    doc: Report genotypes using the maximum-likelihood estimate provided from 
      genotype likelihoods.
    inputBinding:
      position: 102
      prefix: --report-genotype-likelihood-max
  - id: report_monomorphic
    type:
      - 'null'
      - boolean
    doc: Report even loci which appear to be monomorphic, and report all 
      considered alleles, even those which are not in called genotypes. Loci 
      which do not have any potential alternates have '.' for ALT.
    inputBinding:
      position: 102
      prefix: --report-monomorphic
  - id: samples
    type:
      - 'null'
      - File
    doc: Limit analysis to samples listed (one per line) in the FILE. By default
      FreeBayes will analyze all samples in its input BAM files.
    inputBinding:
      position: 102
      prefix: --samples
  - id: skip_coverage
    type:
      - 'null'
      - int
    doc: 'Skip processing of alignments overlapping positions with coverage >N. This
      filters sites above this coverage, but will also reduce data nearby. default:
      no limit'
    inputBinding:
      position: 102
      prefix: --skip-coverage
  - id: standard_filters
    type:
      - 'null'
      - boolean
    doc: Use stringent input base and mapping quality filters Equivalent to -m 
      30 -q 20 -R 0 -S 0
    inputBinding:
      position: 102
      prefix: --standard-filters
  - id: stdin
    type:
      - 'null'
      - boolean
    doc: Read BAM input on stdin.
    inputBinding:
      position: 102
      prefix: --stdin
  - id: strict_vcf
    type:
      - 'null'
      - boolean
    doc: Generate strict VCF format (FORMAT/GQ will be an int)
    inputBinding:
      position: 102
      prefix: --strict-vcf
  - id: targets
    type:
      - 'null'
      - File
    doc: Limit analysis to targets listed in the BED-format FILE.
    inputBinding:
      position: 102
      prefix: --targets
  - id: theta
    type:
      - 'null'
      - float
    doc: 'The expected mutation rate or pairwise nucleotide diversity among the population
      under analysis. This serves as the single parameter to the Ewens Sampling Formula
      prior model default: 0.001'
    default: 0.001
    inputBinding:
      position: 102
      prefix: --theta
  - id: throw_away_complex_obs
    type:
      - 'null'
      - boolean
    doc: Remove complex allele observations from input.
    inputBinding:
      position: 102
      prefix: --throw-away-complex-obs
  - id: throw_away_indels_obs
    type:
      - 'null'
      - boolean
    doc: Remove indel observations from input.
    inputBinding:
      position: 102
      prefix: --throw-away-indels-obs
  - id: throw_away_mnp_obs
    type:
      - 'null'
      - boolean
    doc: Remove MNP observations from input.
    inputBinding:
      position: 102
      prefix: --throw-away-mnp-obs
  - id: throw_away_snp_obs
    type:
      - 'null'
      - boolean
    doc: Remove SNP observations from input.
    inputBinding:
      position: 102
      prefix: --throw-away-snp-obs
  - id: trim_complex_tail
    type:
      - 'null'
      - boolean
    doc: Trim complex tails.
    inputBinding:
      position: 102
      prefix: --trim-complex-tail
  - id: use_best_n_alleles
    type:
      - 'null'
      - int
    doc: 'Evaluate only the best N SNP alleles, ranked by sum of supporting quality
      scores. (Set to 0 to use all; default: all)'
    inputBinding:
      position: 102
      prefix: --use-best-n-alleles
  - id: use_duplicate_reads
    type:
      - 'null'
      - boolean
    doc: 'Include duplicate-marked alignments in the analysis. default: exclude duplicates
      marked as such in alignments'
    inputBinding:
      position: 102
      prefix: --use-duplicate-reads
  - id: use_mapping_quality
    type:
      - 'null'
      - boolean
    doc: Use mapping quality of alleles when calculating data likelihoods.
    inputBinding:
      position: 102
      prefix: --use-mapping-quality
  - id: use_reference_allele
    type:
      - 'null'
      - boolean
    doc: This flag includes the reference allele in the analysis as if it is 
      another sample from the same population.
    inputBinding:
      position: 102
      prefix: --use-reference-allele
  - id: variant_input
    type:
      - 'null'
      - File
    doc: Use variants reported in VCF file as input to the algorithm. Variants 
      in this file will included in the output even if there is not enough 
      support in the data to pass input filters.
    inputBinding:
      position: 102
      prefix: --variant-input
outputs:
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: 'Output VCF-format results to FILE. (default: stdout)'
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freebayes:1.3.10--hbefcdb2_0
