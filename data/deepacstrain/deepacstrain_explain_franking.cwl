cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac-strain
  - explain
  - franking
label: deepacstrain_explain_franking
doc: "Generate filter rankings.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: mode
    type:
      - 'null'
      - type: enum
        symbols:
          - "original"
          - "rel_true_class"
          - "rel_pred_class"
    doc: "Use original filter scores or normalize scores relative to true or predicted classes."
    inputBinding:
      position: 101
      prefix: --mode
  - id: scores_dir
    type: Directory
    doc: "Directory containing filter contribution scores (.csv)"
    inputBinding:
      position: 101
      prefix: --scores-dir
  - id: true_label
    type: File
    doc: "File with true read labels (.npy)"
    inputBinding:
      position: 101
      prefix: --true-label
  - id: pred_label
    type: File
    doc: "File with predicted read labels (.npy)"
    inputBinding:
      position: 101
      prefix: --pred-label
  - id: out_dir
    type: string
    doc: "Output directory"
    default: "franking"
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
