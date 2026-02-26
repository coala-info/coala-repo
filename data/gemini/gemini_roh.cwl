cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini roh
label: gemini_roh
doc: "Finds regions of homozygosity (ROH) in a VCF file.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried.
    inputBinding:
      position: 1
  - id: max_hets
    type:
      - 'null'
      - int
    doc: Maximum number of allowed hets in the run
    default: 1
    inputBinding:
      position: 102
      prefix: --max-hets
  - id: max_unknowns
    type:
      - 'null'
      - int
    doc: Maximum number of allowed unknowns in the run
    default: 3
    inputBinding:
      position: 102
      prefix: --max-unknowns
  - id: min_gt_depth
    type:
      - 'null'
      - int
    doc: The minimum required sequencing depth underlying a given sample's 
      genotypefor a SNP to be considered
    default: 0
    inputBinding:
      position: 102
      prefix: --min-gt-depth
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum run size in base pairs
    default: 100000
    inputBinding:
      position: 102
      prefix: --min-size
  - id: min_snps
    type:
      - 'null'
      - int
    doc: Minimum number of homozygous snps expected in a run
    default: 25
    inputBinding:
      position: 102
      prefix: --min-snps
  - id: min_total_depth
    type:
      - 'null'
      - int
    doc: The minimum overall sequencing depth requiredfor a SNP to be considered
    default: 20
    inputBinding:
      position: 102
      prefix: --min-total-depth
  - id: samples
    type:
      - 'null'
      - string
    doc: Comma separated list of samples to screen for ROHs. e.g S120,S450
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_roh.out
