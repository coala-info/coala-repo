cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
  - explain
  - xlogos
label: deepacstrain_explain_xlogos
doc: "Get extended sequence logos.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: fasta_dir
    type: Directory
    doc: "Directory containing motifs per filter (.fasta)"
    inputBinding:
      position: 101
      prefix: --fasta-dir
  - id: scores_dir
    type: Directory
    doc: "Directory containing nucleotide scores per filter (.csv)"
    inputBinding:
      position: 101
      prefix: --scores-dir
  - id: logo_dir
    type:
      - 'null'
      - Directory
    doc: "Directory containing motifs in weighted transfac format (only required if weighted weblogos should be created)"
    inputBinding:
      position: 101
      prefix: --logo-dir
  - id: gain
    type:
      - 'null'
      - int
    doc: "Color saturation gain. Weblogo colors reach saturation when the average nt score=1/gain. Default: 128000. Recommended: input length * number of filters."
    inputBinding:
      position: 101
      prefix: --gain
  - id: train_data
    type:
      - 'null'
      - File
    doc: "Training data set to compute GC-content"
    inputBinding:
      position: 101
      prefix: --train-data
  - id: out_dir
    type: string
    doc: "Output directory"
    default: "xlogos"
    inputBinding:
      position: 101
      prefix: --out-dir
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
