cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
  - explain
  - fa2transfac
label: deepacstrain_explain_fa2transfac
doc: "Calculate transfac from fasta files.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: in_dir
    type: Directory
    doc: "Directory containing motifs per filter (.fasta)"
    inputBinding:
      position: 101
      prefix: --in-dir
  - id: out_dir
    type: string
    doc: "Output directory"
    default: "transfac"
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: weighting
    type:
      - 'null'
      - boolean
    doc: "Weight sequences by their DeepLIFT score"
    inputBinding:
      position: 101
      prefix: --weighting
  - id: weight_dir
    type:
      - 'null'
      - Directory
    doc: "Directory containing the DeepLIFT scores per filter (only required if --weighting is chosen)"
    inputBinding:
      position: 101
      prefix: --weight-dir
outputs:
  - id: out
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepacstrain:0.2.1--py_0
