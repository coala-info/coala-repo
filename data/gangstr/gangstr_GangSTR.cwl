cwlVersion: v1.2
class: CommandLineTool
baseCommand: GangSTR
label: gangstr_GangSTR
doc: "This program takes in aligned reads in BAM format and outputs estimated genotypes
  at each TR in VCF format.\n\nTool homepage: https://github.com/gymreklab/GangSTR"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Comma separated list of input BAM files
    inputBinding:
      position: 101
      prefix: --bam
  - id: bam_samps
    type:
      - 'null'
      - string
    doc: Comma separated list of sample IDs for --bam
    inputBinding:
      position: 101
      prefix: --bam-samps
  - id: chrom
    type:
      - 'null'
      - string
    doc: Only genotype regions on this chromosome
    inputBinding:
      position: 101
      prefix: --chrom
  - id: coverage
    type:
      - 'null'
      - type: array
        items: float
    doc: Average coverage. must be set for exome/targeted data. Comma separated 
      list to specify for each BAM
    inputBinding:
      position: 101
      prefix: --coverage
  - id: enclweight
    type:
      - 'null'
      - float
    doc: 'Weight for enclosing reads. Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --enclweight
  - id: flankweight
    type:
      - 'null'
      - float
    doc: 'Weight for flanking reads. Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --flankweight
  - id: frrweight
    type:
      - 'null'
      - float
    doc: 'Weight for FRR reads. Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --frrweight
  - id: grid_threshold
    type:
      - 'null'
      - int
    doc: 'Use optimization rather than grid search to find MLE if more than this many
      possible alleles. Default: 10000'
    default: 10000
    inputBinding:
      position: 101
      prefix: --grid-threshold
  - id: include_ggl
    type:
      - 'null'
      - boolean
    doc: Output GGL (special GL field) in VCF
    inputBinding:
      position: 101
      prefix: --include-ggl
  - id: insertmean
    type:
      - 'null'
      - type: array
        items: float
    doc: Fragment length mean. Comma separated list to specify for each BAM 
      separately.
    inputBinding:
      position: 101
      prefix: --insertmean
  - id: insertsdev
    type:
      - 'null'
      - type: array
        items: float
    doc: Fragment length standard deviation. Comma separated list to specify for
      each BAM separately.
    inputBinding:
      position: 101
      prefix: --insertsdev
  - id: max_proc_read
    type:
      - 'null'
      - int
    doc: 'Maximum number of processed reads per sample before a region is skipped.
      Default: 3000'
    default: 3000
    inputBinding:
      position: 101
      prefix: --max-proc-read
  - id: min_sample_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads per sample.
    inputBinding:
      position: 101
      prefix: --min-sample-reads
  - id: minmatch
    type:
      - 'null'
      - int
    doc: 'Minimum number of matching basepairs on each end of enclosing reads. Default:
      5'
    default: 5
    inputBinding:
      position: 101
      prefix: --minmatch
  - id: minscore
    type:
      - 'null'
      - int
    doc: 'Minimum alignment score (out of 100). Default: 75'
    default: 75
    inputBinding:
      position: 101
      prefix: --minscore
  - id: model_gc_coverage
    type:
      - 'null'
      - boolean
    doc: Model coverage as a function of GC content. Requires genome-wide data
    inputBinding:
      position: 101
      prefix: --model-gc-coverage
  - id: nonuniform
    type:
      - 'null'
      - boolean
    doc: Indicate whether data has non-uniform coverage (i.e., exome)
    inputBinding:
      position: 101
      prefix: --nonuniform
  - id: numbstrap
    type:
      - 'null'
      - int
    doc: 'Number of bootstrap samples. Default: 100'
    default: 100
    inputBinding:
      position: 101
      prefix: --numbstrap
  - id: outprefix
    type: string
    doc: Prefix to name output files
    inputBinding:
      position: 101
      prefix: --out
  - id: output_bootstraps
    type:
      - 'null'
      - boolean
    doc: Output file with bootstrap samples
    inputBinding:
      position: 101
      prefix: --output-bootstraps
  - id: output_readinfo
    type:
      - 'null'
      - boolean
    doc: Output read class info (for debugging)
    inputBinding:
      position: 101
      prefix: --output-readinfo
  - id: period
    type:
      - 'null'
      - string
    doc: Only genotype loci with periods (motif lengths) in this comma-separated
      list.
    inputBinding:
      position: 101
      prefix: --period
  - id: ploidy
    type:
      - 'null'
      - int
    doc: 'Indicate whether data is haploid (1) or diploid (2). Default: -1'
    default: -1
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print anything
    inputBinding:
      position: 101
      prefix: --quiet
  - id: read_prob_mode
    type:
      - 'null'
      - boolean
    doc: Use only read probability (ignore class probability)
    inputBinding:
      position: 101
      prefix: --read-prob-mode
  - id: readlength
    type:
      - 'null'
      - int
    doc: 'Read length. Default: -1'
    default: -1
    inputBinding:
      position: 101
      prefix: --readlength
  - id: ref
    type: File
    doc: FASTA file for the reference genome
    inputBinding:
      position: 101
      prefix: --ref
  - id: regions
    type: File
    doc: BED file containing TR coordinates
    inputBinding:
      position: 101
      prefix: --regions
  - id: rescue_count
    type:
      - 'null'
      - int
    doc: 'Number of regions that GangSTR attempts to rescue mates from (excluding
      off-target regions) Default: 0'
    default: 0
    inputBinding:
      position: 101
      prefix: --rescue-count
  - id: samp_sex
    type:
      - 'null'
      - string
    doc: Comma separated list of sample sex for each sample ID (--bam-samps must
      be provided)
    inputBinding:
      position: 101
      prefix: --samp-sex
  - id: seed
    type:
      - 'null'
      - string
    doc: Random number generator initial seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: skip_qscore
    type:
      - 'null'
      - boolean
    doc: Skip calculation of Q-score
    inputBinding:
      position: 101
      prefix: --skip-qscore
  - id: skipofftarget
    type:
      - 'null'
      - boolean
    doc: Skip off target regions included in the BED file.
    inputBinding:
      position: 101
      prefix: --skipofftarget
  - id: spanweight
    type:
      - 'null'
      - float
    doc: 'Weight for spanning reads. Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: --spanweight
  - id: str_info
    type:
      - 'null'
      - string
    doc: Tab file with additional per-STR info (see docs)
    inputBinding:
      position: 101
      prefix: --str-info
  - id: stutterdown
    type:
      - 'null'
      - float
    doc: 'Stutter deletion probability. Default: 0.05'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --stutterdown
  - id: stutterprob
    type:
      - 'null'
      - float
    doc: 'Stutter step size parameter. Default: 0.9'
    default: 0.9
    inputBinding:
      position: 101
      prefix: --stutterprob
  - id: stutterup
    type:
      - 'null'
      - float
    doc: 'Stutter insertion probability. Default: 0.05'
    default: 0.05
    inputBinding:
      position: 101
      prefix: --stutterup
  - id: targeted
    type:
      - 'null'
      - boolean
    doc: Targeted mode
    inputBinding:
      position: 101
      prefix: --targeted
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out useful progress messages
    inputBinding:
      position: 101
      prefix: --verbose
  - id: very
    type:
      - 'null'
      - boolean
    doc: Print out more detailed progress messages for debugging
    inputBinding:
      position: 101
      prefix: --very
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gangstr:2.5.0--h7337834_10
stdout: gangstr_GangSTR.out
