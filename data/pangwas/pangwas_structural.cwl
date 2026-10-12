cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - structural
label: pangwas_structural
doc: "Extract structural variants from cluster alignments.\n\nTakes as input the summarized clusters and their individual alignments.\nOutputs an Rtab file of structural variants.\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: clusters
    type: File
    doc: "TSV of clusters from summarize."
    inputBinding:
      position: 101
      prefix: --clusters
  - id: alignments
    type: Directory
    doc: "Directory of cluster alignments (not consensus alignments!)."
    inputBinding:
      position: 101
      prefix: --alignments
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
  - id: min_len
    type:
      - 'null'
      - int
    doc: "Minimum variant length. (default: 10)"
    inputBinding:
      position: 101
      prefix: --min-len
  - id: min_indel_len
    type:
      - 'null'
      - int
    doc: "Minimum indel length. (default: 3)"
    inputBinding:
      position: 101
      prefix: --min-indel-len
outputs:
  - id: structural_rtab
    type: File
    doc: "Rtab file of structural variants"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'structural.Rtab')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
