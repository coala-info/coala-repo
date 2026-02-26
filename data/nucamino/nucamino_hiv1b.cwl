cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nucamino
  - hiv1b
label: nucamino_hiv1b
doc: "Use HIV-1 type B consensus from LANL to align input sequences; support genes
  POL (56gag + 99PR + 560RT + 288IN)\n\nTool homepage: https://github.com/hivdb/nucamino"
inputs:
  - id: gap_extension_penalty
    type:
      - 'null'
      - float
    doc: penalty score when a gap was extended
    default: 2
    inputBinding:
      position: 101
      prefix: --gap-extension-penalty
  - id: gap_opening_penalty
    type:
      - 'null'
      - float
    doc: penalty score when a gap was opened
    default: 10
    inputBinding:
      position: 101
      prefix: --gap-opening-penalty
  - id: gene
    type:
      - 'null'
      - string
    doc: gene(s) the input sequences should be aligned with
    inputBinding:
      position: 101
      prefix: --gene
  - id: goroutines
    type:
      - 'null'
      - int
    doc: number of goroutines the alignment will use. Use the core number when 
      equals to 0
    default: 0
    inputBinding:
      position: 101
      prefix: --goroutines
  - id: indel_codon_extension_bonus
    type:
      - 'null'
      - float
    doc: bonus score when a indel codon was extended
    default: 2
    inputBinding:
      position: 101
      prefix: --indel-codon-extension-bonus
  - id: indel_codon_opening_bonus
    type:
      - 'null'
      - float
    doc: bonus score when a indel codon was opened
    default: 0
    inputBinding:
      position: 101
      prefix: --indel-codon-opening-bonus
  - id: input
    type:
      - 'null'
      - File
    doc: FASTA file contains one or more DNA sequences
    default: '-'
    inputBinding:
      position: 101
      prefix: --input
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format of the alignment result
    default: tsv
    inputBinding:
      position: 101
      prefix: --output-format
  - id: pprof
    type:
      - 'null'
      - boolean
    doc: output pprof benchmark result
    inputBinding:
      position: 101
      prefix: --pprof
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: hide non-error information output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: stop_codon_penalty
    type:
      - 'null'
      - float
    doc: penalty score when a stop codon was met
    default: 4
    inputBinding:
      position: 101
      prefix: --stop-codon-penalty
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output destination of the alignment results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucamino:0.1.3--0
