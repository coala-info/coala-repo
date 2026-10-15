cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanini_infer_gene
label: ppanini_infer_gene
doc: "Infer genes with a sufficient UniRef90 map from alignment hits (DIAMOND tabular output with query and subject lengths).\n\nTool homepage: http://huttenhower.sph.harvard.edu/ppanini"
inputs:
  - id: hits
    type: File
    doc: "Alignment hits table (tabular, 14 columns)"
    inputBinding:
      position: 110
  - id: min_percid
    type: float
    doc: "Minimum percent identity (fraction)"
    inputBinding:
      position: 101
      prefix: --min-percid
  - id: min_qcover
    type: float
    doc: "Minimum query coverage (fraction)"
    inputBinding:
      position: 101
      prefix: --min-qcover
  - id: min_scover
    type: float
    doc: "Minimum subject coverage (fraction)"
    inputBinding:
      position: 101
      prefix: --min-scover
  - id: all_valid_hits
    type:
      - 'null'
      - boolean
    doc: "Keep all valid hits of a gene, not only the first"
    inputBinding:
      position: 101
      prefix: --all-valid-hits
  - id: output_path
    type: string
    doc: "Output directory (created by the tool)"
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: Directory
    doc: "Directory with uniref_gene_map.txt, hits.txt and no_hits.txt"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanini:0.7.4--py_0
stdout: ppanini_infer_gene.out
