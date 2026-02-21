cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parascopy
  - call
label: parascopy_call
doc: "Call variants in duplicated regions.\n\nTool homepage: https://github.com/tprodanov/parascopy"
inputs:
  - id: alternate_count
    type:
      - 'null'
      - int
    doc: Minimum alternate allele read count (in at least one sample), corresponds
      to freebayes parameter -C
    default: 4
    inputBinding:
      position: 101
      prefix: --alternate-count
  - id: alternate_fraction
    type:
      - 'null'
      - float
    doc: Minimum alternate allele read fraction (in at least one sample), corresponds
      to freebayes parameter -F
    default: 0.05
    inputBinding:
      position: 101
      prefix: --alternate-fraction
  - id: assume_cn
    type:
      - 'null'
      - File
    doc: Instead of using Parascopy paralog-specific copy number values, use copy
      number from the input file with columns "chrom start end samples copy_num".
    inputBinding:
      position: 101
      prefix: --assume-cn
  - id: base_qual
    type:
      - 'null'
      - type: array
        items: int
    doc: Ignore observations with low base quality (first for SNPs, second for indels)
    default:
      - 10
      - 10
    inputBinding:
      position: 101
      prefix: --base-qual
  - id: clean
    type:
      - 'null'
      - string
    doc: 'Which temporary files to remove (multi-letter code: v, p).'
    inputBinding:
      position: 101
      prefix: --clean
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output additional debug information.
    inputBinding:
      position: 101
      prefix: --debug
  - id: error_rate
    type:
      - 'null'
      - type: array
        items: float
    doc: 'Two error rates: first for SNPs, second for indels'
    default:
      - 0.01
      - 0.01
    inputBinding:
      position: 101
      prefix: --error-rate
  - id: fasta_ref
    type: File
    doc: Input reference fasta file.
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: freebayes
    type:
      - 'null'
      - File
    doc: 'Optional: path to the modified Freebayes executable.'
    inputBinding:
      position: 101
      prefix: --freebayes
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Optional: Input indexed BAM/CRAM files. All entries should follow the format
      "filename[::sample]"'
    inputBinding:
      position: 101
      prefix: --input
  - id: input_list
    type:
      - 'null'
      - File
    doc: 'Optional: A file containing a list of input BAM/CRAM files.'
    inputBinding:
      position: 101
      prefix: --input-list
  - id: limit_depth
    type:
      - 'null'
      - type: array
        items: int
    doc: Min and max variant read depth
    default:
      - 3
      - 2000
    inputBinding:
      position: 101
      prefix: --limit-depth
  - id: limit_pooled
    type:
      - 'null'
      - float
    doc: Based solely on allelic read depth, ignore pooled genotypes with probabilities
      under 10^<float>
    default: -5
    inputBinding:
      position: 101
      prefix: --limit-pooled
  - id: limit_qual
    type:
      - 'null'
      - float
    doc: Skip SNVs that do not overlap PSVs and have Freebayes quality under <float>
    default: 1
    inputBinding:
      position: 101
      prefix: --limit-qual
  - id: max_agcn
    type:
      - 'null'
      - int
    doc: Maximum aggregate copy number
    default: 10
    inputBinding:
      position: 101
      prefix: --max-agcn
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: Log10 mutation rate (used for calculating genotype priors)
    default: -3
    inputBinding:
      position: 101
      prefix: --mutation-rate
  - id: n_alleles
    type:
      - 'null'
      - int
    doc: Use at most <int> best alleles (set 0 to all), corresponds to freebayes parameter
      -n
    default: 3
    inputBinding:
      position: 101
      prefix: --n-alleles
  - id: no_mate_penalty
    type:
      - 'null'
      - float
    doc: Penalize possible paired-read alignment positions in case they do not match
      second read alignment position (log10 penalty)
    default: -5
    inputBinding:
      position: 101
      prefix: --no-mate-penalty
  - id: parascopy
    type: Directory
    doc: Input directory with Parascopy copy number estimates.
    inputBinding:
      position: 101
      prefix: --parascopy
  - id: psv_ref_gt
    type:
      - 'null'
      - float
    doc: Use all PSVs (even unreliable) if they have a reference paralog-specific
      genotype (genotype quality >= <float>)
    default: 20
    inputBinding:
      position: 101
      prefix: --psv-ref-gt
  - id: regions
    type:
      - 'null'
      - File
    doc: Limit analysis to regions in the provided BED file.
    inputBinding:
      position: 101
      prefix: --regions
  - id: regions_subset
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Additionally filter input regions: only use regions with names that are
      in this list.'
    inputBinding:
      position: 101
      prefix: --regions-subset
  - id: rerun
    type:
      - 'null'
      - string
    doc: 'Rerun analysis for all loci: full, partial, or none.'
    default: none
    inputBinding:
      position: 101
      prefix: --rerun
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Limit the analysis to the provided sample names or files with sample names.
    inputBinding:
      position: 101
      prefix: --samples
  - id: samtools
    type:
      - 'null'
      - File
    doc: Path to "samtools" executable
    default: samtools
    inputBinding:
      position: 101
      prefix: --samtools
  - id: skip_paralog
    type:
      - 'null'
      - boolean
    doc: Do not calculate paralog-specific genotypes.
    inputBinding:
      position: 101
      prefix: --skip-paralog
  - id: strand_bias
    type:
      - 'null'
      - float
    doc: Maximum strand bias (Phred score)
    default: 30
    inputBinding:
      position: 101
      prefix: --strand-bias
  - id: tabix
    type:
      - 'null'
      - File
    doc: Path to "tabix" executable. Use "none" to skip indexing output files.
    default: tabix
    inputBinding:
      position: 101
      prefix: --tabix
  - id: table
    type: File
    doc: Input indexed bed table with information about segmental duplications.
    inputBinding:
      position: 101
      prefix: --table
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of available threads
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: unpaired_bias
    type:
      - 'null'
      - float
    doc: Maximum unpaired bias (Phred score)
    default: 30
    inputBinding:
      position: 101
      prefix: --unpaired-bias
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory. Required if -i or -I arguments were used.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parascopy:1.19.0--py312hc576ae5_0
