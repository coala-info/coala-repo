cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikado
  - util
  - stats
label: mikado_util_stats
doc: "GFF/GTF statistics: median/average length of RNAs, exons, CDS features, etc.\n\nTool homepage: https://github.com/EI-CoreBioinformatics/mikado"
inputs:
  - id: only_coding
    type:
      - 'null'
      - boolean
    doc: Only consider coding transcripts.
    inputBinding:
      position: 101
      prefix: --only-coding
  - id: tab_stats
    type:
      - 'null'
      - string
    doc: Tabular file to write statistics for each transcript.
    inputBinding:
      position: 101
      prefix: --tab-stats
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 101
      prefix: -v
  - id: gff
    type: File
    doc: GFF file to parse.
    inputBinding:
      position: 201
  - id: out
    type:
      - 'null'
      - string
    doc: Output file name; printed to standard output if omitted.
    inputBinding:
      position: 202
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file.
    outputBinding:
      glob: $(inputs.out)
  - id: stdout_text
    type: stdout
    doc: Output printed to standard output when no output file is given.
  - id: tab_stats_file
    type:
      - 'null'
      - File
    doc: Per-transcript statistics.
    outputBinding:
      glob: $(inputs.tab_stats)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
stdout: mikado_util_stats.out
