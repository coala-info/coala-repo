cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - summary_from_stats
label: pomoxis_summary_from_stats
doc: "Summarise the output of `stats_from_bam`.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Output of `stats_from_bam` (read from standard input when not given).
    inputBinding:
      position: 102
      prefix: --input
  - id: output
    type:
      - 'null'
      - string
    default: summary.txt
    doc: Output summary to this file instead of stderr.
    inputBinding:
      position: 102
      prefix: --output
  - id: percentiles
    type:
      - 'null'
      - type: array
        items: int
    doc: Percentiles for the summary (default 10 50 90).
    inputBinding:
      position: 102
      prefix: --percentiles
  - id: per_reference
    type:
      - 'null'
      - boolean
    doc: Also output a summary for each reference.
    inputBinding:
      position: 102
      prefix: --per_reference
  - id: accumulate
    type:
      - 'null'
      - int
    doc: Accumulate chunks in the summary (default 1).
    inputBinding:
      position: 102
      prefix: --accumulate
outputs:
  - id: summary
    type: File
    doc: Summary table.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
