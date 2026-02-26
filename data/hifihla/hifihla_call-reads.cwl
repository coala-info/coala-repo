cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifihla call-reads
label: hifihla_call-reads
doc: "Call HLA loci from an aligned BAM of HiFi reads\n\nTool homepage: https://github.com/PacificBiosciences/hifihla"
inputs:
  - id: aligned_reads
    type: File
    doc: Input assembly aligned to GRCh38 (no alts)
    inputBinding:
      position: 101
      prefix: --abam
  - id: full_length
    type:
      - 'null'
      - boolean
    doc: Full length IMGT records only (exclude exon-only records)
    inputBinding:
      position: 101
      prefix: --full_length
  - id: haplotypes
    type:
      - 'null'
      - int
    doc: Haplotypes in sample
    default: 2
    inputBinding:
      position: 101
      prefix: --haplotypes
  - id: loci
    type:
      - 'null'
      - type: array
        items: string
    doc: Input comma-sep loci to extract
    default: all
    inputBinding:
      position: 101
      prefix: --loci
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Alternative to repeated -v/--verbose: set log level via key.'
    default: Warn
    inputBinding:
      position: 101
      prefix: --log-level
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum reads per locus
    default: 50
    inputBinding:
      position: 101
      prefix: --max_depth
  - id: max_matches
    type:
      - 'null'
      - int
    doc: Maximum matches in output report
    default: 10
    inputBinding:
      position: 101
      prefix: --max_matches
  - id: min_allele_freq
    type:
      - 'null'
      - float
    doc: Minimum allele frequency
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min_allele_freq
  - id: min_cdf
    type:
      - 'null'
      - float
    doc: Minimum binomial CDF to call het/hom
    default: 0.001
    inputBinding:
      position: 101
      prefix: --min_cdf
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --out_prefix
  - id: partial
    type:
      - 'null'
      - boolean
    doc: Include partially-spanning reads
    inputBinding:
      position: 101
      prefix: --partial
  - id: preset
    type:
      - 'null'
      - string
    doc: Sequence type presets
    inputBinding:
      position: 101
      prefix: --preset
  - id: seed
    type:
      - 'null'
      - int
    doc: Random number seed for downsampling to max_depth
    default: 42
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Analysis threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory [deprecated]
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifihla:0.3.1--hdfd78af_0
