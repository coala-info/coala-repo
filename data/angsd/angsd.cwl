cwlVersion: v1.2
class: CommandLineTool
baseCommand: angsd
label: angsd
doc: "Analysis of Next Generation Sequencing Data. Methods for estimating allele frequencies,
  genotype likelihoods, and other population genetic parameters from NGS data.\n\n
  Tool homepage: http://www.popgen.dk/angsd/index.php/ANGSD"
inputs:
  - id: anc
    type:
      - 'null'
      - File
    doc: Read ancestral genome
    inputBinding:
      position: 101
      prefix: -anc
  - id: bam
    type:
      - 'null'
      - File
    doc: Options relating to bam reading (often a file containing a list of BAMs)
    inputBinding:
      position: 101
      prefix: -bam
  - id: cigstat
    type:
      - 'null'
      - int
    doc: Printout CIGAR stat across readlength
    inputBinding:
      position: 101
      prefix: -cigstat
  - id: do_abbababa
    type:
      - 'null'
      - int
    doc: Perform an ABBA-BABA test
    inputBinding:
      position: 101
      prefix: -doAbbababa
  - id: do_anc_error
    type:
      - 'null'
      - int
    doc: Estimate the errorrate based on perfect fastas
    inputBinding:
      position: 101
      prefix: -doAncError
  - id: do_asso
    type:
      - 'null'
      - int
    doc: Perform association study
    inputBinding:
      position: 101
      prefix: -doAsso
  - id: do_bcf
    type:
      - 'null'
      - int
    doc: Wrapper around -dopost -domajorminor -dofreq -gl -dovcf docounts
    inputBinding:
      position: 101
      prefix: -doBcf
  - id: do_counts
    type:
      - 'null'
      - int
    doc: Calculate various counts statistics
    inputBinding:
      position: 101
      prefix: -doCounts
  - id: do_error
    type:
      - 'null'
      - int
    doc: Estimate the type specific error rates
    inputBinding:
      position: 101
      prefix: -doError
  - id: do_fasta
    type:
      - 'null'
      - int
    doc: Generate a fasta for a BAM file
    inputBinding:
      position: 101
      prefix: -doFasta
  - id: do_geno
    type:
      - 'null'
      - int
    doc: Call genotypes
    inputBinding:
      position: 101
      prefix: -doGeno
  - id: do_het_plas
    type:
      - 'null'
      - int
    doc: Estimate hetplasmy by calculating a pooled haploid frequency
    inputBinding:
      position: 101
      prefix: -doHetPlas
  - id: do_maf
    type:
      - 'null'
      - int
    doc: Estimate allele frequencies
    inputBinding:
      position: 101
      prefix: -doMaf
  - id: do_major_minor
    type:
      - 'null'
      - int
    doc: Infer the major/minor using different approaches
    inputBinding:
      position: 101
      prefix: -doMajorMinor
  - id: do_saf
    type:
      - 'null'
      - int
    doc: Estimate the SFS and/or neutrality tests genotype calling
    inputBinding:
      position: 101
      prefix: -doSaf
  - id: do_snp_stat
    type:
      - 'null'
      - int
    doc: Calculate various SNPstat
    inputBinding:
      position: 101
      prefix: -doSNPstat
  - id: gl
    type:
      - 'null'
      - int
    doc: Estimate genotype likelihoods
    inputBinding:
      position: 101
      prefix: -GL
  - id: how_often
    type:
      - 'null'
      - int
    doc: How often should the program show progress
    inputBinding:
      position: 101
      prefix: -howOften
  - id: hwe_pval
    type:
      - 'null'
      - float
    doc: Est inbreedning per site or use as filter
    inputBinding:
      position: 101
      prefix: -HWE_pval
  - id: n_queue_size
    type:
      - 'null'
      - int
    doc: Maximum number of queued elements
    inputBinding:
      position: 101
      prefix: -nQueueSize
  - id: n_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: -nThreads
  - id: ref
    type:
      - 'null'
      - File
    doc: Read reference genome
    inputBinding:
      position: 101
      prefix: -ref
  - id: sites
    type:
      - 'null'
      - File
    doc: Analyse specific sites (can force major/minor)
    inputBinding:
      position: 101
      prefix: -sites
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file prefix
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/angsd:0.940--h13024bc_4
