cwlVersion: v1.2
class: CommandLineTool
baseCommand: superstr-visualise.py
label: superstr_superstr-visualise.py
doc: "Draw split violin plots of superSTR repeat metrics for an affected group against a control group.\n\nTool homepage: https://github.com/bahlolab/superSTR"
inputs:
  - id: manifest
    type: File
    doc: path to manifest file
    inputBinding:
      position: 1
      prefix: -m
  - id: input_path
    type: File
    doc: input path, a per-motif CSV file from superstr-multiparse.py (for example motifs/3mers/AAG.csv)
    inputBinding:
      position: 2
      prefix: -i
  - id: output
    type: string
    doc: output file name; matplotlib saves the file in the format given by the extension (PDF, PNG etc)
    inputBinding:
      position: 3
      prefix: -o
  - id: fig_height
    type:
      - 'null'
      - float
    doc: figure height (inches) (default 8.97638)
    inputBinding:
      position: 4
      prefix: -fh
  - id: fig_width
    type:
      - 'null'
      - float
    doc: figure width (inches) (default 6.49606)
    inputBinding:
      position: 5
      prefix: -fw
  - id: aff_col
    type:
      - 'null'
      - string
    doc: color for affected group; matplotlib color or hex (default '#3B6978')
    inputBinding:
      position: 6
      prefix: --aff_col
  - id: ctrl_col
    type:
      - 'null'
      - string
    doc: color for control/background group; matplotlib color or hex (default 'lightgrey')
    inputBinding:
      position: 7
      prefix: --ctrl_col
  - id: ctrl_lab
    type:
      - 'null'
      - string
    doc: label for control/background group; case sensitive
    inputBinding:
      position: 8
      prefix: --ctrl_lab
  - id: aff_lab
    type:
      - 'null'
      - string
    doc: label for affected group; case sensitive
    inputBinding:
      position: 9
      prefix: --aff_lab
outputs:
  - id: plot
    type: File
    doc: Plot
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
