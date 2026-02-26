cwlVersion: v1.2
class: CommandLineTool
baseCommand: whatshap genotype
label: whatshap_genotype
doc: "Genotype variants\n\nRuns only the genotyping algorithm. Genotype Likelihoods
  are computed using the\nforward backward algorithm.\n\nTool homepage: https://whatshap.readthedocs.io"
inputs:
  - id: vcf
    type: File
    doc: VCF file with variants to be genotyped (can be gzip-compressed)
    inputBinding:
      position: 1
  - id: phase_input
    type:
      type: array
      items: File
    doc: BAM or VCF file(s) with phase information, either through sequencing 
      reads (BAM) or through phased blocks (VCF)
    inputBinding:
      position: 2
  - id: affine_gap
    type:
      - 'null'
      - boolean
    doc: When detecting alleles through re-alignment, use affine gap costs 
      (EXPERIMENTAL).
    inputBinding:
      position: 103
      prefix: --affine-gap
  - id: chromosome
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of chromosome to genotyped. If not given, all chromosomes in the 
      input VCF are genotyped. Can be used multiple times.
    inputBinding:
      position: 103
      prefix: --chromosome
  - id: constant
    type:
      - 'null'
      - float
    doc: 'This constant is used to regularize the priors (default: 0).'
    default: 0
    inputBinding:
      position: 103
      prefix: --constant
  - id: exclude_chromosome
    type:
      - 'null'
      - string
    doc: Name of chromosome not to be genotyped.
    inputBinding:
      position: 103
      prefix: --exclude-chromosome
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: 'gap extend penalty in case affine gap costs are used (default: 7).'
    default: 7
    inputBinding:
      position: 103
      prefix: --gap-extend
  - id: gap_start
    type:
      - 'null'
      - int
    doc: 'gap starting penalty in case affine gap costs are used (default: 10).'
    default: 10
    inputBinding:
      position: 103
      prefix: --gap-start
  - id: genmap
    type:
      - 'null'
      - File
    doc: File with genetic map (used with --ped) to be used instead of constant 
      recombination rate, i.e. overrides option --recombrate.
    inputBinding:
      position: 103
      prefix: --genmap
  - id: gt_qual_threshold
    type:
      - 'null'
      - float
    doc: 'Phred scaled error probability threshold used for genotyping (default: 0).
      Must be at least 0. If error probability of genotype is higher, genotype ./.
      is output.'
    default: 0
    inputBinding:
      position: 103
      prefix: --gt-qual-threshold
  - id: ignore_read_groups
    type:
      - 'null'
      - boolean
    doc: Ignore read groups in BAM header and assume all reads come from the 
      same sample.
    inputBinding:
      position: 103
      prefix: --ignore-read-groups
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: kmer size used by kmerald during re-alignment.
    inputBinding:
      position: 103
      prefix: --kmer-size
  - id: kmerald_gappenalty
    type:
      - 'null'
      - int
    doc: Gap penalty used by kmerald during re-alignment.
    inputBinding:
      position: 103
      prefix: --kmerald-gappenalty
  - id: kmerald_window
    type:
      - 'null'
      - int
    doc: Consider this many bases on the left and side of a variant position for
      kmerald based re-alignment.
    inputBinding:
      position: 103
      prefix: --kmerald-window
  - id: kmeralign_costs
    type:
      - 'null'
      - string
    doc: Error model based costs used by kmerald during re-alignment.
    inputBinding:
      position: 103
      prefix: --kmeralign-costs
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    default: 20
    inputBinding:
      position: 103
      prefix: --mapping-quality
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Reduce coverage to at most MAXCOV
    default: 15
    inputBinding:
      position: 103
      prefix: --max-coverage
  - id: mismatch
    type:
      - 'null'
      - int
    doc: 'mismatch cost in case affine gap costs are used (default: 15)'
    default: 15
    inputBinding:
      position: 103
      prefix: --mismatch
  - id: no_priors
    type:
      - 'null'
      - boolean
    doc: 'Skip initial prior genotyping and use uniform priors (default: False).'
    default: false
    inputBinding:
      position: 103
      prefix: --no-priors
  - id: only_snvs
    type:
      - 'null'
      - boolean
    doc: Genotype only SNVs
    inputBinding:
      position: 103
      prefix: --only-snvs
  - id: overhang
    type:
      - 'null'
      - int
    doc: 'When --reference is used, extend alignment by this many bases to left and
      right when realigning (default: 10).'
    default: 10
    inputBinding:
      position: 103
      prefix: --overhang
  - id: ped
    type:
      - 'null'
      - File
    doc: Use pedigree information in PED file to improve genotyping (switches to
      PedMEC algorithm). Columns 2, 3, 4 must refer to child, father, and mother
      sample names as used in the VCF and BAM. Other columns are ignored 
      (EXPERIMENTAL).
    inputBinding:
      position: 103
      prefix: --ped
  - id: prioroutput
    type:
      - 'null'
      - File
    doc: output prior genotype likelihoods to the given file.
    inputBinding:
      position: 103
      prefix: --prioroutput
  - id: recombrate
    type:
      - 'null'
      - float
    doc: 'Recombination rate in cM/Mb (used with --ped). If given, a constant recombination
      rate is assumed (default: 1.26cM/Mb).'
    default: 1.26
    inputBinding:
      position: 103
      prefix: --recombrate
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference file. Provide this to detect alleles through re-alignment. If
      no index (.fai) exists, it will be created
    inputBinding:
      position: 103
      prefix: --reference
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
    doc: Name of a sample to genotype. If not given, all samples in the input 
      VCF are genotyped. Can be used multiple times.
    inputBinding:
      position: 103
      prefix: --sample
  - id: use_kmerald
    type:
      - 'null'
      - boolean
    doc: Use kmerald for detecting alleles through re-alignment.
    inputBinding:
      position: 103
      prefix: --use-kmerald
  - id: use_ped_samples
    type:
      - 'null'
      - boolean
    doc: Only work on samples mentioned in the provided PED file.
    inputBinding:
      position: 103
      prefix: --use-ped-samples
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output VCF file. Add .gz to the file name to get compressed output. If 
      omitted, use standard output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatshap:2.8--py39h2de1943_0
