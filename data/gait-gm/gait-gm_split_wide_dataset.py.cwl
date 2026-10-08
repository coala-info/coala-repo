cwlVersion: v1.2
class: CommandLineTool
baseCommand: split_wide_dataset.py
label: gait-gm_split_wide_dataset.py
doc: "split_wide_dataset: split a wide dataset into wide, design and annotation files.

Tool homepage: https://github.com/secimTools/gait-gm"
inputs:
  - id: input
    type: File
    doc: "Input dataset in wide format."
    inputBinding:
      position: 101
      prefix: --input
  - id: uniq_id
    type:
      - 'null'
      - string
    doc: "Name of the column with unique identifiers."
    inputBinding:
      position: 101
      prefix: --ID
  - id: samples
    type: string
    doc: "Select sample columns (comma-separated column numbers)."
    inputBinding:
      position: 101
      prefix: --samples
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix to add to the new unique ID."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: prefix2
    type:
      - 'null'
      - string
    doc: "Prefix to add to the old unique ID (only if the Unique ID is numeric)."
    inputBinding:
      position: 101
      prefix: --prefix2
  - id: wide_path
    type: string
    doc: "Wide dataset file."
    inputBinding:
      position: 101
      prefix: --wide
  - id: design_path
    type: string
    doc: "Design file."
    inputBinding:
      position: 101
      prefix: --design
  - id: annot_path
    type: string
    doc: "Annotation file."
    inputBinding:
      position: 101
      prefix: --annot
outputs:
  - id: wide
    type: File
    doc: "Wide dataset file"
    outputBinding:
      glob: $(inputs.wide_path)
  - id: design
    type: File
    doc: "Design file"
    outputBinding:
      glob: $(inputs.design_path)
  - id: annot
    type: File
    doc: "Annotation file"
    outputBinding:
      glob: $(inputs.annot_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
