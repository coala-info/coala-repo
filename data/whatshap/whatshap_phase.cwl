cwlVersion: v1.2
class: CommandLineTool
baseCommand: whatshap phase
label: whatshap_phase
doc: "Phase variants in a VCF with the WhatsHap algorithm\n\nTool homepage: https://whatshap.readthedocs.io"
inputs:
  - id: vcf
    type: File
    doc: VCF or BCF file with variants to be phased (can be gzip-compressed)
    inputBinding:
      position: 1
  - id: phase_inputs
    type:
      type: array
      items: File
    doc: BAM, CRAM, VCF or BCF file(s) with phase information, either through 
      sequencing reads (BAM, CRAM) or through phased blocks (VCF, BCF)
    inputBinding:
      position: 2
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'Phasing algorithm to use (default: whatshap)'
    inputBinding:
      position: 103
      prefix: --algorithm
  - id: changed_genotype_list
    type:
      - 'null'
      - File
    doc: Write list of changed genotypes to FILE.
    inputBinding:
      position: 103
      prefix: --changed-genotype-list
  - id: chromosome
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of chromosome to phase. If not given, all chromosomes in the input
      VCF are phased. Can be used multiple times.
    inputBinding:
      position: 103
      prefix: --chromosome
  - id: default_gq
    type:
      - 'null'
      - int
    doc: Default genotype quality used as cost of changing a genotype when no 
      genotype likelihoods are available (default 30)
    inputBinding:
      position: 103
      prefix: --default-gq
  - id: distrust_genotypes
    type:
      - 'null'
      - boolean
    doc: Allow switching variants from hetero- to homozygous in an optimal 
      solution (see documentation).
    inputBinding:
      position: 103
      prefix: --distrust-genotypes
  - id: error_rate
    type:
      - 'null'
      - float
    doc: 'The probability that a nucleotide is wrong in read merging model (default:
      0.15).'
    inputBinding:
      position: 103
      prefix: --error-rate
  - id: exclude_chromosome
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of chromosome not to phase.
    inputBinding:
      position: 103
      prefix: --exclude-chromosome
  - id: genmap
    type:
      - 'null'
      - File
    doc: File with genetic map (used with --ped) to be used instead of constant 
      recombination rate, i.e. overrides option --recombrate.
    inputBinding:
      position: 103
      prefix: --genmap
  - id: gl_regularizer
    type:
      - 'null'
      - float
    doc: Constant (float) to be used to regularize genotype likelihoods read 
      from input VCF (default None).
    inputBinding:
      position: 103
      prefix: --gl-regularizer
  - id: ignore_read_groups
    type:
      - 'null'
      - boolean
    doc: Ignore read groups in BAM/CRAM header and assume all reads come from 
      the same sample.
    inputBinding:
      position: 103
      prefix: --ignore-read-groups
  - id: include_homozygous
    type:
      - 'null'
      - boolean
    doc: Also work on homozygous variants, which might be turned to heterozygous
    inputBinding:
      position: 103
      prefix: --include-homozygous
  - id: internal_downsampling
    type:
      - 'null'
      - int
    doc: 'Coverage reduction parameter in the internal core phasing algorithm. Higher
      values increase runtime *exponentially* while possibly improving phasing quality
      marginally. Avoid using this in the normal case! (default: 15)'
    inputBinding:
      position: 103
      prefix: --internal-downsampling
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: 'Minimum mapping quality (default: 20)'
    inputBinding:
      position: 103
      prefix: --mapping-quality
  - id: maximum_error_rate
    type:
      - 'null'
      - float
    doc: 'The maximum error rate of any edge of the read merging graph before discarding
      it (default: 0.25).'
    inputBinding:
      position: 103
      prefix: --maximum-error-rate
  - id: merge_reads
    type:
      - 'null'
      - boolean
    doc: 'Merge reads which are likely to come from the same haplotype (default: do
      not merge reads)'
    inputBinding:
      position: 103
      prefix: --merge-reads
  - id: negative_threshold
    type:
      - 'null'
      - float
    doc: 'The threshold of the ratio between the probabilities that a pair of reads
      come from different haplotypes and the same haplotype in the read merging model
      (default: 1000).'
    inputBinding:
      position: 103
      prefix: --negative-threshold
  - id: no_genetic_haplotyping
    type:
      - 'null'
      - boolean
    doc: 'Do not merge blocks that are not connected by reads (i.e. solely based on
      genotype status). Default: when in --ped mode, merge all blocks that contain
      at least one homozygous genotype in at least one individual into one block.'
    inputBinding:
      position: 103
      prefix: --no-genetic-haplotyping
  - id: no_reference
    type:
      - 'null'
      - boolean
    doc: Detect alleles without requiring a reference, at the expense of phasing
      quality (in particular for long reads)
    inputBinding:
      position: 103
      prefix: --no-reference
  - id: only_snvs
    type:
      - 'null'
      - boolean
    doc: Phase only SNVs
    inputBinding:
      position: 103
      prefix: --only-snvs
  - id: output_read_list
    type:
      - 'null'
      - File
    doc: Write reads that have been used for phasing to FILE.
    inputBinding:
      position: 103
      prefix: --output-read-list
  - id: ped
    type:
      - 'null'
      - File
    doc: Use pedigree information in PED file to improve phasing (switches to 
      PedMEC algorithm). Columns 2, 3, 4 must refer to child, father, and mother
      sample names as used in the VCF and BAM/CRAM. Other columns are ignored.
    inputBinding:
      position: 103
      prefix: --ped
  - id: recombination_list
    type:
      - 'null'
      - File
    doc: Write putative recombination events to FILE.
    inputBinding:
      position: 103
      prefix: --recombination-list
  - id: recombrate
    type:
      - 'null'
      - string
    doc: 'Recombination rate in cM/Mb (used with --ped). If given, a constant recombination
      rate is assumed (default: 1.26cM/Mb).'
    inputBinding:
      position: 103
      prefix: --recombrate
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference file. Must be accompanied by .fai index (create with samtools
      faidx)
    inputBinding:
      position: 103
      prefix: --reference
  - id: row_limit
    type:
      - 'null'
      - int
    doc: 'For the heuristic: Maximum number of memorized intermediate solutions. Larger
      values increase runtime and memory consumption, but can improve phasing quality.
      (default: None)'
    inputBinding:
      position: 103
      prefix: --row-limit
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of a sample to phase. If not given, all samples in the input VCF 
      are phased. Can be used multiple times.
    inputBinding:
      position: 103
      prefix: --sample
  - id: supplementary_distance
    type:
      - 'null'
      - int
    doc: 'Skip supplementary alignments further than DIST bp away from the primary
      alignment (default: 100000)'
    inputBinding:
      position: 103
      prefix: --supplementary-distance
  - id: tag
    type:
      - 'null'
      - string
    doc: 'Store phasing information with PS tag (standardized) or HP tag (used by
      GATK ReadBackedPhasing) (default: PS)'
    inputBinding:
      position: 103
      prefix: --tag
  - id: threshold
    type:
      - 'null'
      - float
    doc: 'The threshold of the ratio between the probabilities that a pair of reads
      come from the same haplotype and different haplotypes in the read merging model
      (default: 1000000).'
    inputBinding:
      position: 103
      prefix: --threshold
  - id: use_ped_samples
    type:
      - 'null'
      - boolean
    doc: Only work on samples mentioned in the provided PED file.
    inputBinding:
      position: 103
      prefix: --use-ped-samples
  - id: use_supplementary
    type:
      - 'null'
      - boolean
    doc: 'Use also supplementary alignments (default: ignore supplementary_ alignments)'
    inputBinding:
      position: 103
      prefix: --use-supplementary
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output VCF file. Add .gz to the file name to get compressed output. If 
      omitted, use standard output.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
