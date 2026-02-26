cwlVersion: v1.2
class: CommandLineTool
baseCommand: blacksheep-outliers
label: blacksheep-outliers
doc: "Perform outlier analysis on a table of values, typically for proteomics data.
  It calculates thresholds based on Interquartile Range (IQR) and identifies values
  exceeding those thresholds.\n\nTool homepage: https://github.com/ruggleslab/blackSheep/"
inputs:
  - id: values_file
    type: File
    doc: The file with the values to be used for outlier analysis (e.g., a CSV 
      or TSV of protein abundances).
    inputBinding:
      position: 1
  - id: down_only
    type:
      - 'null'
      - boolean
    doc: Only look for down outliers.
    inputBinding:
      position: 102
      prefix: --down_only
  - id: fraction_samples
    type:
      - 'null'
      - float
    doc: The fraction of samples that must have a value for a site to be 
      included.
    default: 0.3
    inputBinding:
      position: 102
      prefix: --fraction_samples
  - id: iqrs
    type:
      - 'null'
      - float
    doc: The number of IQRs to use for the outlier threshold.
    default: 1.5
    inputBinding:
      position: 102
      prefix: --iqrs
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: The prefix for the output files.
    inputBinding:
      position: 102
      prefix: --output_prefix
  - id: up_only
    type:
      - 'null'
      - boolean
    doc: Only look for up outliers.
    inputBinding:
      position: 102
      prefix: --up_only
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blacksheep-outliers:0.0.8--py_0
stdout: blacksheep-outliers.out
