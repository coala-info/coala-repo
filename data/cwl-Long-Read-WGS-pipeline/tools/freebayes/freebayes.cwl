#!/usr/bin/env cwltool

cwlVersion: v1.2
class: CommandLineTool

label: freebayes, Bayesian haplotype-based genetic polymorphism discovery and genotyping

doc: |
  freebayes is a Bayesian genetic variant detector designed to find small polymorphisms, specifically:
  SNPs (single-nucleotide polymorphisms), indels (insertions and deletions), MNPs (multi-nucleotide polymorphisms),
  and complex events (composite insertion and substitution events) smaller than the length of a short-read sequencing alignment.
  Documentation on how to install and run freebayes can be found here:
  https://github.com/freebayes/freebayes


requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement: # this is required as a workaround: freebayes expects a fasta.fai file to be alongside its fasta files. Here, we make sure that both files are mounted into the same directory
    listing:
      - entry: $(inputs.reference_fasta)
      - entry: $(inputs.reference_fasta_index)

hints:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/freebayes:1.3.8--h6a68c12_2
  SoftwareRequirement:
    packages:
      freebayes:
        version: ["1.3.8"]
        specs: ["identifiers.org/RRID:SCR_010761 "]
  
baseCommand: freebayes

inputs:
  reference_fasta:
    type: File
    label: "Reference FASTA file"
    doc: "Reference FASTA file input. Must be indexed (FAI file must exist)."
    inputBinding:
      prefix: -f
  reference_fasta_index:
    type: File
  bam_file:
    type: File?
    label: "BAM file"
    doc: "One BAM file (indexed) for variant calling."
    inputBinding:
      itemSeparator: " " 
  bam_files:
    type: File[]?
    label: "BAM files"
    doc: "Multiple more BAM files (indexed) for variant calling."
    inputBinding:
      itemSeparator: " " # test if multiple bam files works - > also make it conditional on one of these two inputs, or just completely remove array support tbh
  ploidy:
    type: int?
    label: ploidy settings
    doc: Settings of the ploidy, for haploid organisms, set to 1.
    inputBinding:
      prefix: --ploidy
  usedup:
    type: boolean?
    label: use duplicate alignments
    doc: Use duplicate-marked alignments in the analysis. Defaults to exclude duplicates.
    inputBinding:
      prefix: --use-duplicate-reads
  min_mapq:
    type: int?
    label: minimum mapping quality
    doc: Exclude alignments with mapping quality less than Q. Defaults to 1.
    inputBinding:
      prefix: --min-mapping-quality
  min_baseq:
    type: int?
    label: minimum base quality
    doc: Exclude alleles with base quality less than Q. Defaults to 0.
    inputBinding:
      prefix: --min-base-quality
  min_allele_qsum:
    type: int?
    label: minimum allele quality sum
    doc: Require supporting allele quality sum to be at least Q. Defaults to 0.
    inputBinding:
      prefix: --min-supporting-allele-qsum
  min_mapqsum:
    type: int?
    label: mininmum supporting mapping quality
    doc: Require supporting mapping quality sum to be at least Q. Defaults to 0.
    inputBinding:
      prefix: --min-supporting-mapping-qsum
  mismatch_bq:
    type: int?
    label: mismatch base quality
    doc: Count mismatches if base quality is at least Q. Defaults to 10.
    inputBinding:
      prefix: --mismatch-base-quality-threshold
  read_mismatch_limit:
    type: int?
    label: read mismatch limit
    doc: Exclude reads with more than N mismatches with high base quality.
    inputBinding:
      prefix: --read-mismatch-limit
  read_max_mismatch_fraction:
    type: float?
    label: maximum read mismatch fraction
    doc: Exclude reads with a mismatch fraction greater than N. Defaults to 1.0.
    inputBinding:
      prefix: --read-max-mismatch-fraction
  read_snp_limit:
    type: int?
    label: read SNP limit
    doc: Exclude reads with more than N base mismatches ignoring gaps.
    inputBinding:
      prefix: --read-snp-limit
  read_indel_limit:
    type: int?
    label: read indel limit
    doc: Exclude reads with more than N separate gaps.
    inputBinding:
      prefix: --read-indel-limit
  standard_filters:
    type: boolean?
    label: standard filters
    doc: Use stringent input quality filters.
    inputBinding:
      prefix: --standard-filters
  min_alt_frac:
    type: float?
    label: minimum alternate fraction
    doc: Require at least this fraction of observations supporting an alternate allele. Defaults to 0.05.
    inputBinding:
      prefix: --min-alternate-fraction
  min_alt_count:
    type: int?
    label: minimum alternate count
    doc: Require at least this count of observations supporting an alternate allele. Defaults to 2.
    inputBinding:
      prefix: --min-alternate-count
  min_alt_qsum:
    type: int?
    label: minimum alternate quality sum
    doc: Require at least this quality sum of observations supporting an alternate allele. Defaults to 0.
    inputBinding:
      prefix: --min-alternate-qsum
  min_alt_total:
    type: int?
    label: minimum alternate total
    doc: Require at least this total count of observations supporting an alternate allele. Defaults to 1.
    inputBinding:
      prefix: --min-alternate-total
  min_cov:
    type: int?
    label: minimum coverage
    doc: Process sites with at least this coverage. Defaults to 0.
    inputBinding:
      prefix: --min-coverage
  limit_cov:
    type: int?
    label: limit coverage
    doc: Downsample per-sample coverage to this level.
    inputBinding:
      prefix: --limit-coverage
  skip_cov:
    type: int?
    label: skip coverage
    doc: Skip processing positions with coverage greater than N.
    inputBinding:
      prefix: --skip-coverage
  trim_complex_tail:
    type: boolean?
    label: trim complex tail
    doc: Trim complex tails.
    inputBinding:
      prefix: --trim-complex-tail
  no_pop_priors:
    type: boolean?
    label: no population priors
    doc: Disable population priors.
    inputBinding:
      prefix: --no-population-priors
  # mappability priors:
  hwe_priors_off:
    type: boolean?
    label: disable HWE priors
    doc: | 
      Disable estimation of the probability of the combination arising under HWE given the allele frequency as estimated by observation frequency.
    inputBinding:
      prefix: --hwe-priors-off
  binom_obs_priors_off:
    type: boolean?
    label: disable binomial observation priors
    doc: |
      Disable incorporation of prior expectation about observations.
      Uses read placement probability, strand balance probability, and read position (5'-3') probability.
    inputBinding:
      prefix: --binomial-obs-priors-off
  allele_balance_priors_off:
    type: boolean?
    label: disable allele balance priors
    doc: Disable use of aggregate probability of observation balance between alleles as a component of the priors.
    inputBinding:
      prefix: --allele-balance-priors-off
  observation_bias:
    type: File?
    label: observation bias
    doc: Read length dependent allele observation biases from file.
    inputBinding:
      prefix: --observation-bias
  base_quality_cap:
    type: int?
    label: base quality cap
    doc: Cap estimated base quality at the specified value.
    inputBinding:
      prefix: --base-quality-cap
  prob_contamination:
    type: float?
    label: probability contamination
    doc: Estimate of contamination to use for all samples. Defaults to 10e-9.
    inputBinding:
      prefix: --prob-contamination
  legacy_gls:
    type: boolean?
    label: legacy genotype likelihood calculations
    doc: Use legacy genotype likelihood calculations.
    inputBinding:
      prefix: --legacy-gls
  contamination_estimates:
    type: File?
    label: contamination estimates
    doc: File containing per-sample contamination estimates.
    inputBinding:
      prefix: --contamination-estimates
  # algorithmic features:
  report_geno_like_max:
    type: boolean?
    label: report genotype using maximum-likelihood estimates
    doc: Report genotypes using maximum-likelihood estimates.
    inputBinding:
      prefix: --report-genotype-likelihood-max
  genotyping_max_iterations:
    type: int?
    label: genotyping maximum iterations
    doc: Maximum iterations during genotyping. Defaults to 1000.
    inputBinding:
      prefix: --genotyping-max-iterations
  genotyping_max_banddepth:
    type: int?
    label: genotyping maximum banddepth
    doc: Limit integration to the Nth best genotype likelihood. Defaults to 6.
    inputBinding:
      prefix: --genotyping-max-banddepth
  posterior_integration_limits:
    type: string?
    label: posterior integration limits
    doc: Posterior integration limits as N,M.
    inputBinding:
      prefix: --posterior-integration-limits
  exclude_unobserved_genotypes:
    type: boolean?
    label: exclude unobserved genotypes
    doc: Skip genotyping for samples with no supporting reads.
    inputBinding:
      prefix: --exclude-unobserved-genotypes
  genotype_variant_threshold:
    type: int?
    label: genotype variant threshold
    doc: Threshold for evaluating variant genotype likelihood.
    inputBinding:
      prefix: --genotype-variant-threshold
  use_mapq:
    type: boolean?
    label: use mapping quality
    doc: Use mapping quality in genotype likelihood calculations.
    inputBinding:
      prefix: --use-mapping-quality
  harmonic_indel_quality:
    type: boolean?
    label: harmonic indel quality
    doc: Use weighted sum of flanking base qualities for indels.
    inputBinding:
      prefix: --harmonic-indel-quality
  read_dependence_factor:
    type: float?
    label: read dependence factor
    doc: Scale successive read observations by this factor. Defaults to 0.9
    inputBinding:
      prefix: --read-dependence-factor
  genotype_qualities:
    type: boolean?
    label: genotype qualities
    doc: Calculate and report genotype qualities.
    inputBinding:
      prefix: --genotype-qualities

outputs:
  vcf:
    type: File
    outputBinding:
      glob: freebayes_output.vcf
stdout: freebayes_output.vcf

$namespaces:
  s: https://schema.org/   
  edam: http://edamontology.org/ 
s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0009-0005-0017-0928
    s:email: mailto:martijn.melissen@wur.nl
    s:name: Martijn Melissen
s:citation: https://m-unlock.nl
s:codeRepository: https://git.wur.nl/ssb/automated-data-analysis
s:dateCreated: "2025-02-11"
s:dateModified: "2025-03-06"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"