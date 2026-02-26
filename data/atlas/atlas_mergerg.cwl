cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
label: atlas_mergerg
doc: "ATLAS 2.0.1\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas/wiki/Home"
inputs:
  - id: allele_counts
    type:
      - 'null'
      - boolean
    doc: Estimating population allele counts
    inputBinding:
      position: 101
  - id: allele_freq
    type:
      - 'null'
      - boolean
    doc: Estimating population allele frequencies
    inputBinding:
      position: 101
  - id: allelic_depth
    type:
      - 'null'
      - boolean
    doc: Writing genotype likelihoods to a GLF file
    inputBinding:
      position: 101
  - id: ancestral_alleles
    type:
      - 'null'
      - boolean
    doc: Writing FASTA-file with ancestral alleles
    inputBinding:
      position: 101
  - id: assess_soft_clipping
    type:
      - 'null'
      - boolean
    doc: Assessing level of soft clipping in BAM file
    inputBinding:
      position: 101
  - id: bam_diagnostics
    type:
      - 'null'
      - boolean
    doc: Estimating depth and read property frequencies
    inputBinding:
      position: 101
  - id: calculate_f2
    type:
      - 'null'
      - boolean
    doc: Calculate F2 between samples, and within/between populations
    inputBinding:
      position: 101
  - id: call
    type:
      - 'null'
      - boolean
    doc: Calling genotypes
    inputBinding:
      position: 101
  - id: convert_vcf
    type:
      - 'null'
      - boolean
    doc: Converting a VCF file to other formats
    inputBinding:
      position: 101
  - id: create_mask
    type:
      - 'null'
      - boolean
    doc: Creating a mask BED file
    inputBinding:
      position: 101
  - id: downsample
    type:
      - 'null'
      - boolean
    doc: Downsampling a BAM file
    inputBinding:
      position: 101
  - id: estimate_errors
    type:
      - 'null'
      - boolean
    doc: Estimating PMD pattern and Sequencing Errors
    inputBinding:
      position: 101
  - id: filter_bam
    type:
      - 'null'
      - boolean
    doc: Writing reads that pass filters to BAM file
    inputBinding:
      position: 101
  - id: genetic_dist
    type:
      - 'null'
      - boolean
    doc: Estimating the genetic distance between individuals
    inputBinding:
      position: 101
  - id: glf
    type:
      - 'null'
      - boolean
    doc: Writing genotype likelihoods to a GLF file
    inputBinding:
      position: 101
  - id: identify_illumina
    type:
      - 'null'
      - boolean
    doc: Reassigning read groups based on the platform unit in their name
    inputBinding:
      position: 101
  - id: inbreeding
    type:
      - 'null'
      - boolean
    doc: Estimating the inbreeding coefficient
    inputBinding:
      position: 101
  - id: major_minor
    type:
      - 'null'
      - boolean
    doc: Estimating major and minor alles
    inputBinding:
      position: 101
  - id: merge_overlapping_reads
    type:
      - 'null'
      - boolean
    doc: Merging paired-end reads in BAM file
    inputBinding:
      position: 101
  - id: merge_rg
    type:
      - 'null'
      - boolean
    doc: Merging read groups in a BAM file
    inputBinding:
      position: 101
  - id: mutation_load
    type:
      - 'null'
      - boolean
    doc: Estimating mutation load across the genome
    inputBinding:
      position: 101
  - id: pileup
    type:
      - 'null'
      - boolean
    doc: Printing pileup from BAM file
    inputBinding:
      position: 101
  - id: pileup_to_bed
    type:
      - 'null'
      - boolean
    doc: Create bed file from pileup file
    inputBinding:
      position: 101
  - id: pmds
    type:
      - 'null'
      - boolean
    doc: Filtering for ancient reads using PMDS
    inputBinding:
      position: 101
  - id: print_glf
    type:
      - 'null'
      - boolean
    doc: Printing a GLF file to screen
    inputBinding:
      position: 101
  - id: psmc
    type:
      - 'null'
      - boolean
    doc: Generating a PSMC Input file probabilistically
    inputBinding:
      position: 101
  - id: quality_transformation
    type:
      - 'null'
      - boolean
    doc: Printing Quality Transformation
    inputBinding:
      position: 101
  - id: saf
    type:
      - 'null'
      - boolean
    doc: Estimating Site Allele Frequencies
    inputBinding:
      position: 101
  - id: simulate
    type:
      - 'null'
      - boolean
    doc: Simulate bam- or vcf-file[s]
    inputBinding:
      position: 101
  - id: summary_stats
    type:
      - 'null'
      - boolean
    doc: 'Summary statistics per window/genomewide: Felsenstein, HKY85, Pi'
    inputBinding:
      position: 101
  - id: test_hardy_weinberg
    type:
      - 'null'
      - boolean
    doc: Testing for Hardy-Weinberg equilibrium across multiple populations
    inputBinding:
      position: 101
  - id: theta_ratio
    type:
      - 'null'
      - boolean
    doc: Estimate ratio in heterozygosity (theta) between genomic regions
    inputBinding:
      position: 101
  - id: vcf_compare
    type:
      - 'null'
      - boolean
    doc: Comparing genotype calls in two VCF files
    inputBinding:
      position: 101
  - id: vcf_diagnostics
    type:
      - 'null'
      - boolean
    doc: Diagnosing a VCF file
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_mergerg.out
