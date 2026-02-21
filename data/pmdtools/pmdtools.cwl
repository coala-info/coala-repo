cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmdtools
label: pmdtools
doc: "Post-mortem DNA damage analysis. This tool computes PMD scores for ancient DNA
  sequences and can be used to filter or visualize deamination patterns.\n\nTool homepage:
  https://github.com/pontussk/PMDtools"
inputs:
  - id: custom
    type:
      - 'null'
      - boolean
    doc: Use custom deamination rates.
    inputBinding:
      position: 101
      prefix: --custom
  - id: deamination
    type:
      - 'null'
      - boolean
    doc: Calculate deamination patterns (C->T and G->A transitions).
    inputBinding:
      position: 101
      prefix: --deamination
  - id: fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA file for identifying mismatches.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: header
    type:
      - 'null'
      - boolean
    doc: Include the SAM header in the output.
    inputBinding:
      position: 101
      prefix: --header
  - id: mask
    type:
      - 'null'
      - boolean
    doc: Mask deaminated sites in the output sequences.
    inputBinding:
      position: 101
      prefix: --mask
  - id: number
    type:
      - 'null'
      - boolean
    doc: Output the PMD score as a tag in the SAM/BAM file.
    inputBinding:
      position: 101
      prefix: --number
  - id: platypus
    type:
      - 'null'
      - boolean
    doc: Use the Platypus model for PMD score calculation.
    inputBinding:
      position: 101
      prefix: --platypus
  - id: range
    type:
      - 'null'
      - int
    doc: Number of bases from the ends of the DNA fragments to consider for PMD analysis.
    default: 25
    inputBinding:
      position: 101
      prefix: --range
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Output summary statistics of the PMD analysis.
    inputBinding:
      position: 101
      prefix: --stats
  - id: threshold
    type:
      - 'null'
      - float
    doc: PMD score threshold for filtering. Only reads with a score above this value
      will be output.
    default: 3.0
    inputBinding:
      position: 101
      prefix: --threshold
  - id: unique
    type:
      - 'null'
      - boolean
    doc: Only consider unique reads (removes duplicates).
    inputBinding:
      position: 101
      prefix: --unique
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print progress and diagnostic information to stderr.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmdtools:0.60--hdfd78af_3
stdout: pmdtools.out
