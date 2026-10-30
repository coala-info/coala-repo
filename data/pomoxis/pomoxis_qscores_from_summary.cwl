cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qscores_from_summary
label: pomoxis_qscores_from_summary
doc: "Extract Q scores from summary_from_stats output.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: summaries
    type:
      type: array
      items: File
    doc: '*summ.txt files created by summary_from_stats.'
    inputBinding:
      position: 1
  - id: median
    type:
      - 'null'
      - boolean
    doc: Use the median. If false, use the mean.
    inputBinding:
      position: 102
      prefix: --median
  - id: ref
    type:
      - 'null'
      - string
    doc: Process a single reference rather than the overall result.
    inputBinding:
      position: 102
      prefix: --ref
outputs:
  - id: qscores
    type: stdout
    doc: Q scores printed by the tool.
stdout: qscores_from_summary.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
