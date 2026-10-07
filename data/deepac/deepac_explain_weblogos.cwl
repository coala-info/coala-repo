cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac
  - explain
  - weblogos
label: deepac_explain_weblogos
doc: "Get sequence logos.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: in_dir
    type: Directory
    doc: "Directory containing motifs per filter"
    inputBinding:
      position: 101
      prefix: --in-dir
  - id: file_ext
    type:
      - 'null'
      - type: enum
        symbols:
          - ".fasta"
          - ".transfac"
    doc: "Extension of file format of input files (.fasta or .transfac)"
    inputBinding:
      position: 101
      prefix: --file-ext
  - id: train_data
    type:
      - 'null'
      - File
    doc: "Training data set (.npy) to compute GC-content. N-padding lowers GC!"
    inputBinding:
      position: 101
      prefix: --train-data
  - id: out_dir
    type: string
    doc: "Output directory"
    default: "weblogos"
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
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
