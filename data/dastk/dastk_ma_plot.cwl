cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ma_plot
label: dastk_ma_plot
doc: "Draw an MA plot from a DAStk differential MD score stats file (help text: This
  script generates barcodes using the output from DAStk).\n\nTool homepage: https://github.com/Dowell-Lab/DAStk"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.output_dir, listing: []})"
        writable: true
inputs:
  - id: stats
    type: File
    doc: Differential MD score stats file generated from DAStk
      (*_differential_md_scores.txt).
    inputBinding:
      position: 101
      prefix: --stats
  - id: label_1
    type: string
    doc: Label for the MA plot title corresponding to assay 1
    inputBinding:
      position: 101
      prefix: --label-1
  - id: label_2
    type: string
    doc: Label for the MA plot title corresponding to assay 2
    inputBinding:
      position: 101
      prefix: --label-2
  - id: window
    type:
      - 'null'
      - string
    doc: Label for the MA plot title corresponding to window size (str). Default
      = '3kb'
    inputBinding:
      position: 101
      prefix: --window
  - id: p_value
    type:
      - 'null'
      - float
    doc: p-value cutoff to define which motifs to label in the MA plot. Defaults
      to 0.00001.
    inputBinding:
      position: 101
      prefix: --p-value
  - id: label_p_value
    type:
      - 'null'
      - boolean
    doc: Label all TFs falling below the specified p-value cutoff.
    inputBinding:
      position: 101
      prefix: --label_p-value
  - id: output_dir
    type: string
    doc: Folder where the plot will be saved (created by the wrapper).
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (motifs below the p-value cutoff)
  - id: ma_plot
    type: File
    doc: MA plot (MA_<label_1>_to_<label_2>_md_score.png)
    outputBinding:
      glob: $(inputs.output_dir)/MA_$(inputs.label_1)_to_$(inputs.label_2)_md_score.png
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dastk:1.0.1--pyh7cba7a3_0
stdout: dastk_ma_plot.out
