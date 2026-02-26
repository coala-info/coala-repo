cwlVersion: v1.2
class: CommandLineTool
baseCommand: longshot
label: longshot
doc: "variant caller (SNVs) for long-read sequencing data 1.0.0\n\nTool homepage:
  https://github.com/pjedge/longshot"
inputs:
  - id: anchor_length
    type:
      - 'null'
      - int
    doc: Length of indel-free anchor sequence on the left and right side of read
      realignment window.
    default: 6
    inputBinding:
      position: 101
      prefix: --anchor_length
  - id: auto_max_cov
    type:
      - 'null'
      - boolean
    doc: Automatically calculate mean coverage for region and set max coverage 
      to mean_coverage + 5*sqrt(mean_coverage). (SLOWER)
    inputBinding:
      position: 101
      prefix: --auto_max_cov
  - id: bam
    type: File
    doc: sorted, indexed BAM file with error-prone reads
    inputBinding:
      position: 101
      prefix: --bam
  - id: band_width
    type:
      - 'null'
      - int
    doc: Minimum width of alignment band. Band will increase in size if 
      sequences are different lengths.
    default: 20
    inputBinding:
      position: 101
      prefix: --band_width
  - id: density_params
    type:
      - 'null'
      - string
    doc: Parameters to flag a variant as part of a "dense cluster". Format 
      <n>:<l>:<gq>. If there are at least n variants within l base pairs with 
      genotype quality >=gq, then these variants are flagged as "dn"
    default: 10:500:50
    inputBinding:
      position: 101
      prefix: --density_params
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: If output files (VCF or variant debug directory) exist, delete and 
      overwrite them.
    inputBinding:
      position: 101
      prefix: --force_overwrite
  - id: hap_assignment_qual
    type:
      - 'null'
      - float
    doc: Minimum quality (Phred-scaled) of read->haplotype assignment (for read 
      separation).
    default: 20.0
    inputBinding:
      position: 101
      prefix: --hap_assignment_qual
  - id: hap_converge_delta
    type:
      - 'null'
      - float
    doc: Terminate the haplotype/genotype iteration when the relative change in 
      log-likelihood falls below this amount. Setting a larger value results in 
      faster termination but potentially less accurate results.
    default: 0.0001
    inputBinding:
      position: 101
      prefix: --hap_converge_delta
  - id: het_snv_rate
    type:
      - 'null'
      - float
    doc: Specify the heterozygous SNV Rate for genotype prior estimation
    default: 0.001
    inputBinding:
      position: 101
      prefix: --het_snv_rate
  - id: hom_snv_rate
    type:
      - 'null'
      - float
    doc: Specify the homozygous SNV Rate for genotype prior estimation
    default: 0.0005
    inputBinding:
      position: 101
      prefix: --hom_snv_rate
  - id: max_alignment
    type:
      - 'null'
      - boolean
    doc: Use max scoring alignment algorithm rather than pair HMM forward 
      algorithm.
    inputBinding:
      position: 101
      prefix: --max_alignment
  - id: max_cigar_indel
    type:
      - 'null'
      - int
    doc: Throw away a read-variant during allelotyping if there is a CIGAR indel
      (I/D/N) longer than this amount in its window.
    default: 20
    inputBinding:
      position: 101
      prefix: --max_cigar_indel
  - id: max_cov
    type:
      - 'null'
      - int
    doc: Maximum coverage (of reads passing filters) to consider position as a 
      potential SNV.
    default: 8000
    inputBinding:
      position: 101
      prefix: --max_cov
  - id: max_reads_estimation
    type:
      - 'null'
      - int
    doc: number of reads used for estimating alignment parameters, default value
      is 0 which uses all reads
    default: 0
    inputBinding:
      position: 101
      prefix: --max_reads_estimation
  - id: max_snvs
    type:
      - 'null'
      - int
    doc: Cut off variant clusters after this many variants. 2^m haplotypes must 
      be aligned against per read for a variant cluster of size m.
    default: 3
    inputBinding:
      position: 101
      prefix: --max_snvs
  - id: max_window
    type:
      - 'null'
      - int
    doc: Maximum "padding" bases on either side of variant realignment window
    default: 50
    inputBinding:
      position: 101
      prefix: --max_window
  - id: min_allele_qual
    type:
      - 'null'
      - float
    doc: Minimum estimated quality (Phred-scaled) of allele observation on read 
      to use for genotyping/haplotyping.
    default: 7.0
    inputBinding:
      position: 101
      prefix: --min_allele_qual
  - id: min_alt_count
    type:
      - 'null'
      - int
    doc: Require a potential SNV to have at least this many alternate allele 
      observations.
    default: 3
    inputBinding:
      position: 101
      prefix: --min_alt_count
  - id: min_alt_frac
    type:
      - 'null'
      - float
    doc: Require a potential SNV to have at least this fraction of alternate 
      allele observations.
    default: 0.125
    inputBinding:
      position: 101
      prefix: --min_alt_frac
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage (of reads passing filters) to consider position as a 
      potential SNV.
    default: 6
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to use a read.
    default: 20
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: no_haps
    type:
      - 'null'
      - boolean
    doc: Don't call HapCUT2 to phase variants.
    inputBinding:
      position: 101
      prefix: --no_haps
  - id: output_ref
    type:
      - 'null'
      - boolean
    doc: print reference genotypes (non-variant), use this option only in 
      combination with -v option.
    inputBinding:
      position: 101
      prefix: --output-ref
  - id: potential_snv_cutoff
    type:
      - 'null'
      - float
    doc: Consider a site as a potential SNV if the original PHRED-scaled QUAL 
      score for 0/0 genotype is below this amount (a larger value considers more
      potential SNV sites).
    default: 20.0
    inputBinding:
      position: 101
      prefix: --potential_snv_cutoff
  - id: potential_variants
    type:
      - 'null'
      - File
    doc: 'Genotype and phase the variants in this VCF instead of using pileup method
      to find variants. NOTES: VCF must be gzipped and tabix indexed or contain contig
      information. Use with caution because excessive false potential variants can
      lead to inaccurate results. Every variant is used and only the allele fields
      are considered -- Genotypes, filters, qualities etc are ignored. Indel variants
      will be genotyped but not phased. Triallelic variants and structural variants
      are currently not supported.'
    inputBinding:
      position: 101
      prefix: --potential_variants
  - id: ref
    type: File
    doc: indexed FASTA reference that BAM file is aligned to
    inputBinding:
      position: 101
      prefix: --ref
  - id: region
    type:
      - 'null'
      - string
    doc: Region in format <chrom> or <chrom:start-stop> in which to call 
      variants (1-based, inclusive).
    inputBinding:
      position: 101
      prefix: --region
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Specify a sample ID to write to the output VCF
    default: SAMPLE
    inputBinding:
      position: 101
      prefix: --sample_id
  - id: stable_alignment
    type:
      - 'null'
      - boolean
    doc: Use numerically-stable (logspace) pair HMM forward algorithm. Is 
      significantly slower but may be more accurate. Tests have shown this not 
      to be necessary for highly error prone reads (PacBio CLR).
    inputBinding:
      position: 101
      prefix: --stable_alignment
  - id: strand_bias_pvalue_cutoff
    type:
      - 'null'
      - float
    doc: Remove a variant if the allele observations are biased toward one 
      strand (forward or reverse) according to Fisher's exact test. Use this 
      cutoff for the two-tailed P-value.
    default: 0.01
    inputBinding:
      position: 101
      prefix: --strand_bias_pvalue_cutoff
  - id: ts_tv_ratio
    type:
      - 'null'
      - float
    doc: Specify the transition/transversion rate for genotype grior estimation
    default: 0.5
    inputBinding:
      position: 101
      prefix: --ts_tv_ratio
  - id: variant_debug_dir
    type:
      - 'null'
      - Directory
    doc: write out current information about variants at each step of algorithm 
      to files in this directory
    inputBinding:
      position: 101
      prefix: --variant_debug_dir
outputs:
  - id: out
    type: File
    doc: output VCF file with called variants.
    outputBinding:
      glob: $(inputs.out)
  - id: out_bam
    type:
      - 'null'
      - File
    doc: Write new bam file with haplotype tags (HP:i:1 and HP:i:2) for reads 
      assigned to each haplotype, any existing HP and PS tags are removed
    outputBinding:
      glob: $(inputs.out_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longshot:1.0.0--hd4f2111_2
