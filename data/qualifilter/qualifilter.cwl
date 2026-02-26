cwlVersion: v1.2
class: CommandLineTool
baseCommand: qualifilter
label: qualifilter
doc: "QualiFilter: A tool that generates a QC report summarizing key quality metrics
  and sample pass/fail status according to user-defined thresholds\n\nTool homepage:
  https://github.com/buhlentozini/QualiFilter"
inputs:
  - id: attributes
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of columns/metrics to extract
    inputBinding:
      position: 101
      prefix: --attributes
  - id: config
    type:
      - 'null'
      - File
    doc: "Path to YAML or JSON configuration file (optional).\n                  \
      \      Overrides default allowed columns and rename map."
    inputBinding:
      position: 101
      prefix: --config
  - id: derive_reads
    type:
      - 'null'
      - boolean
    doc: Calculate derived read metrics from Kraken percentages
    inputBinding:
      position: 101
      prefix: --derive_reads
  - id: input
    type: File
    doc: MultiQC tabular stats file (TSV)
    inputBinding:
      position: 101
      prefix: --input
  - id: list
    type:
      - 'null'
      - boolean
    doc: List all available columns in the input file and exit
    inputBinding:
      position: 101
      prefix: --list
  - id: round
    type:
      - 'null'
      - int
    doc: Number of decimals for numeric rounding
    inputBinding:
      position: 101
      prefix: --round
  - id: thresholds
    type:
      - 'null'
      - string
    doc: "JSON string with QC thresholds, e.g. {\"Total_reads\":10\n             \
      \           00000,\"Coverage_gte_10x_pct\":90,\"Contam_pct\":5}"
    inputBinding:
      position: 101
      prefix: --thresholds
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qualifilter:1.0.0--pyh7e72e81_0
