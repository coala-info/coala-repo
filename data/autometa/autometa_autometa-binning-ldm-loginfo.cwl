cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-binning-ldm-loginfo
label: autometa_autometa-binning-ldm-loginfo
doc: "Retrieve clustering time stats from autometa.binning.recursive_dbscan err log\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: log
    type: File
    doc: "Path to binning log file (If using slurm, this is typically stderr output path)"
    inputBinding:
      position: 1
      prefix: --log
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Directory to write runtime information tables (default: .)"
    inputBinding:
      position: 1
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix to prepend to runtime information tables (Do not use a directory path as a prefix)"
    inputBinding:
      position: 1
      prefix: --prefix
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrite existing log info table if it already exists"
    inputBinding:
      position: 1
      prefix: --overwrite
outputs:
  - id: info_tables
    type: File[]
    doc: "Runtime information tables"
    outputBinding:
      glob: "${ var d = inputs.outdir ? inputs.outdir + '/' : ''; var p = inputs.prefix ? inputs.prefix : ''; return d + p + '*.tsv'; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
