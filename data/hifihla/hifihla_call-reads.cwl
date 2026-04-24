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
    inputBinding:
      position: 101
      prefix: --haplotypes
  - id: loci
    type:
      - 'null'
      - type: array
        items: string
    doc: Input comma-sep loci to extract
    inputBinding:
      position: 101
      prefix: --loci
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Alternative to repeated -v/--verbose: set log level via key.'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum reads per locus
    inputBinding:
      position: 101
      prefix: --max_depth
  - id: max_matches
    type:
      - 'null'
      - int
    doc: Maximum matches in output report
    inputBinding:
      position: 101
      prefix: --max_matches
  - id: min_allele_freq
    type:
      - 'null'
      - float
    doc: Minimum allele frequency
    inputBinding:
      position: 101
      prefix: --min_allele_freq
  - id: min_cdf
    type:
      - 'null'
      - float
    doc: Minimum binomial CDF to call het/hom
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
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Analysis threads
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
