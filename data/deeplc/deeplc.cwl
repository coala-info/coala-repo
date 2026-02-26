cwlVersion: v1.2
class: CommandLineTool
baseCommand: deeplc
label: deeplc
doc: "Retention time prediction for (modified) peptides using deep learning.\n\nTool
  homepage: http://compomics.github.io/projects/DeepLC"
inputs:
  - id: dict_divider
    type:
      - 'null'
      - float
    doc: sets precision for fast-lookup of retention times for calibration; e.g.
      10 means a precision of 0.1 between the calibration anchor points
    inputBinding:
      position: 101
      prefix: --dict_divider
  - id: file_cal
    type:
      - 'null'
      - File
    doc: path to peptide CSV file with retention times to use for calibration
    inputBinding:
      position: 101
      prefix: --file_cal
  - id: file_model
    type:
      - 'null'
      - type: array
        items: File
    doc: path to prediction model(s); leave empty to select the best of the 
      default models based on the calibration peptides
    inputBinding:
      position: 101
      prefix: --file_model
  - id: file_pred
    type: File
    doc: path to peptide CSV file for which to make predictions (required)
    inputBinding:
      position: 101
      prefix: --file_pred
  - id: log_level
    type:
      - 'null'
      - string
    doc: verbosity of logging messages; default=info
    default: info
    inputBinding:
      position: 101
      prefix: --log_level
  - id: n_threads
    type:
      - 'null'
      - int
    doc: number of CPU threads to use; default=all with max of 16
    default: all with max of 16
    inputBinding:
      position: 101
      prefix: --n_threads
  - id: split_cal
    type:
      - 'null'
      - int
    doc: number of splits in the chromatogram for piecewise linear calibration 
      fit
    inputBinding:
      position: 101
      prefix: --split_cal
  - id: transfer_learning
    type:
      - 'null'
      - boolean
    doc: use transfer learning as calibration method
    inputBinding:
      position: 101
      prefix: --transfer_learning
outputs:
  - id: file_pred_out
    type:
      - 'null'
      - File
    doc: path to write output file with predictions
    outputBinding:
      glob: $(inputs.file_pred_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeplc:3.1.13--pyhdfd78af_0
