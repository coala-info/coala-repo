cwlVersion: v1.2
class: CommandLineTool
baseCommand: add_pval_flags.py
label: gait-gm_add_pval_flags.py
doc: "Add Pval Flags: add flags for P-value thresholds to a differential expression analysis dataset.

Tool homepage: https://github.com/secimTools/gait-gm"
inputs:
  - id: dea_dataset
    type: File
    doc: "Differential Expression Analysis Datset."
    inputBinding:
      position: 101
      prefix: --deaDataset
  - id: uniq_id
    type: string
    doc: "Name of the column with unique identifiers."
    inputBinding:
      position: 101
      prefix: --uniqID
  - id: pvalue
    type: string
    doc: "Name of the column with P-values."
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: thresholds
    type: string
    doc: "P-value thresholds (comma-separated)."
    inputBinding:
      position: 101
      prefix: --thres
  - id: output_path
    type: string
    doc: "Output file name."
    inputBinding:
      position: 101
      prefix: --output
  - id: flags_path
    type: string
    doc: "Flags file name."
    inputBinding:
      position: 101
      prefix: --flags
outputs:
  - id: output
    type: File
    doc: "Output file"
    outputBinding:
      glob: $(inputs.output_path)
  - id: flags
    type: File
    doc: "Flags file"
    outputBinding:
      glob: $(inputs.flags_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
