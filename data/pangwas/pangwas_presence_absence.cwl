cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - presence_absence
label: pangwas_presence_absence
doc: "Extract presence absence of clusters.\n\nTakes as input a TSV of summarized clusters from summarize.\nOutputs an Rtab file of cluster presence/absence.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: clusters
    type: File
    doc: "TSV of clusters from summarize."
    inputBinding:
      position: 101
      prefix: --clusters
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: . )"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files."
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: presence_absence_rtab
    type: File
    doc: "Rtab file of cluster presence/absence"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'presence_absence.Rtab')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
