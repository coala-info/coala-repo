cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ananse
  - influence
label: ananse_influence
doc: "Prioritize transcription factors that explain the difference between two cell types, from their networks and differential gene expression\n\nTool homepage: https://github.com/vanheeringen-lab/ANANSE"
inputs:
  - id: target
    type: File
    doc: "Network of target cell type."
    inputBinding:
      position: 1
      prefix: --target
  - id: degenes
    type: File
    doc: "File with differential gene expression (DEseq2 output file). Genes must be in HGNC symbols, unless a genomepy gene annotation is provided."
    inputBinding:
      position: 1
      prefix: --degenes
  - id: source
    type: ['null', File]
    doc: "Network of source cell type."
    inputBinding:
      position: 1
      prefix: --source
  - id: outfile
    type: ['null', string]
    doc: "Name of the output influence file (default: ./ANANSE_influence.tsv)"
    default: ANANSE_influence.tsv
    inputBinding:
      position: 1
      prefix: --outfile
  - id: full_output
    type: ['null', boolean]
    doc: "Export the full GRN output to the output file"
    inputBinding:
      position: 1
      prefix: --full-output
  - id: annotation
    type: ['null', File]
    doc: "Gene annotation (GTF file) used to quantify expression levels."
    inputBinding:
      position: 1
      prefix: --annotation
  - id: interactions
    type: ['null', int]
    doc: "Number of top TF-gene interactions used (default: 500.000)."
    inputBinding:
      position: 1
      prefix: --interactions
  - id: select_after_join
    type: ['null', boolean]
    doc: "Select top interactions on differential network, instead of input networks."
    inputBinding:
      position: 1
      prefix: --select-after-join
  - id: whitelist
    type: ['null', {type: array, items: string}]
    doc: "Include these genes/interactions after filtering top interactions. Either a space-separated list or a file with one TF/gene/TF-gene interaction per line."
    inputBinding:
      position: 1
      prefix: --whitelist
  - id: padj
    type: ['null', float]
    doc: "Adjusted p-value below which genes classify as differential (default: 0.05)."
    inputBinding:
      position: 1
      prefix: --padj
  - id: column
    type: ['null', string]
    doc: "Column of the network file(s) to select top interactions (default: prob)."
    inputBinding:
      position: 1
      prefix: --column
  - id: ncore
    type: ['null', int]
    doc: "Number of cores to use."
    inputBinding:
      position: 1
      prefix: --ncore
outputs:
  - id: influence
    type: File
    doc: TF influence scores
    outputBinding:
      glob: $(inputs.outfile)
  - id: diffnetwork
    type: ['null', File]
    doc: Differential network (<outfile name>_diffnetwork.tsv)
    outputBinding:
      glob: '*_diffnetwork.tsv'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ananse:0.5.1--pyhdfd78af_0
