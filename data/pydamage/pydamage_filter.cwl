cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pydamage
arguments:
  - position: 3
    valueFrom: filter
label: pydamage_filter
doc: "Filter PyDamage results on predicted accuracy and qvalue thresholds. CSV: path to PyDamage result file.\n\nTool homepage: https://github.com/maxibor/pydamage"
inputs:
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory (default: pydamage_results)."
    inputBinding:
      position: 1
      prefix: --outdir
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Predicted accuracy filtering threshold. Set to 0 for finding threshold with kneed method (default: 0.5)."
    inputBinding:
      position: 2
      prefix: --threshold
  - id: csv
    type: File
    doc: "Path to PyDamage result file."
    inputBinding:
      position: 5
outputs:
  - id: results_dir
    type: Directory
    doc: "Output directory with the results."
    outputBinding:
      glob: "$(inputs.outdir ? inputs.outdir : 'pydamage_results')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydamage:1.0--pyhdfd78af_0
