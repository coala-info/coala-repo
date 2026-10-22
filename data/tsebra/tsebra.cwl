cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsebra.py
label: tsebra
doc: "TSEBRA: Transcript Selector for BRAKER. TSEBRA combines gene predictions by selecting transcripts based on their extrinsic evidence support.\n\nTool homepage: https://github.com/Gaius-Augustus/TSEBRA"
inputs:
  - id: gtf
    type:
      - 'null'
      - type: array
        items: File
    doc: "List of gene prediction files in GTF (joined with commas)"
    inputBinding:
      position: 101
      prefix: -g
      itemSeparator: ','
  - id: keep_gtf
    type:
      - 'null'
      - type: array
        items: File
    doc: "Gene prediction files in GTF used like the other inputs, but TSEBRA ensures all their transcripts are included in the output (joined with commas)"
    inputBinding:
      position: 101
      prefix: -k
      itemSeparator: ','
  - id: hintfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files with extrinsic evidence in GFF (joined with commas)"
    inputBinding:
      position: 101
      prefix: -e
      itemSeparator: ','
  - id: cfg
    type:
      - 'null'
      - File
    doc: "Configuration file that sets the parameters for TSEBRA (recommended: config/default.cfg)"
    inputBinding:
      position: 101
      prefix: -c
  - id: filter_single_exon_genes
    type:
      - 'null'
      - boolean
    doc: "Filter out all single-exon genes that are not supported by at least one start- or stop-codon hint"
    inputBinding:
      position: 101
      prefix: --filter_single_exon_genes
  - id: ignore_tx_phase
    type:
      - 'null'
      - boolean
    doc: "Ignore the phase of transcripts while detecting clusters of overlapping transcripts"
    inputBinding:
      position: 101
      prefix: --ignore_tx_phase
  - id: score_tab_path
    type:
      - 'null'
      - string
    doc: "Prints the transcript scores as a table to the specified file"
    inputBinding:
      position: 101
      prefix: -s
  - id: out_path
    type: string
    doc: "Output file for the combined gene prediction in GTF"
    inputBinding:
      position: 101
      prefix: -o
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Quiet mode"
    inputBinding:
      position: 101
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Verbosity level"
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: out
    type: File
    doc: "Combined gene prediction in GTF"
    outputBinding:
      glob: "$(inputs.out_path)"
  - id: score_tab
    type:
      - 'null'
      - File
    doc: "Transcript scores table"
    outputBinding:
      glob: "$(inputs.score_tab_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
