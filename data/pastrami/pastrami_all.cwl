cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pastrami.py
  - all
label: pastrami_all
doc: "PASTRAMI tool for haplotype-based population structure analysis\n\nTool homepage:
  https://github.com/healthdisparities/pastrami"
inputs:
  - id: debug_mode
    type:
      - 'null'
      - boolean
    doc: Should all debugging file be produced in the output
    inputBinding:
      position: 101
      prefix: --debug_mode
  - id: haplotypes
    type:
      - 'null'
      - File
    doc: File of haplotype positions
    inputBinding:
      position: 101
      prefix: --haplotypes
  - id: map_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory containing genetic maps: chr1.map, chr2.map, etc'
    inputBinding:
      position: 101
      prefix: --map-dir
  - id: max_rate
    type:
      - 'null'
      - float
    doc: Maximum recombination rate
    inputBinding:
      position: 101
      prefix: --max-rate
  - id: max_snps
    type:
      - 'null'
      - int
    doc: Maximum number of SNPs in a haplotype block
    inputBinding:
      position: 101
      prefix: --max-snps
  - id: min_snps
    type:
      - 'null'
      - int
    doc: Minimum number of SNPs in a haplotype block
    inputBinding:
      position: 101
      prefix: --min-snps
  - id: per_individual
    type:
      - 'null'
      - boolean
    doc: Generate per-individual copying rather than per-population copying
    inputBinding:
      position: 101
      prefix: --per-individual
  - id: pop_group
    type:
      - 'null'
      - File
    doc: File containing population to group (e.g., tribes to region) mapping
    inputBinding:
      position: 101
      prefix: --pop-group
  - id: query_prefix
    type: string
    doc: Prefix for the query TPED/TFAM input files
    inputBinding:
      position: 101
      prefix: --query-prefix
  - id: reference_prefix
    type: string
    doc: Prefix for the reference TPED/TFAM input files
    inputBinding:
      position: 101
      prefix: --reference-prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of concurrent threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print program progress information on screen
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_prefix
    type:
      - 'null'
      - File
    doc: 'Output prefix for creating following sets of files: .pickle, _query.tsv,
      .tsv, .fam, _fractions.Q, _paintings.Q, _estimates.Q, _fine_grain_estimates.Q'
    outputBinding:
      glob: $(inputs.out_prefix)
  - id: log_file
    type:
      - 'null'
      - File
    doc: File containing log information
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
