cwlVersion: v1.2
class: CommandLineTool
baseCommand: beamspy summary-results
label: beamspy_summary-results
doc: "Generates a summary of BEAMSpy results.\n\nTool homepage: https://github.com/computational-metabolomics/beamspy"
inputs:
  - id: convert_rt
    type:
      - 'null'
      - string
    doc: Covert the retention time to seconds or minutes. An additional column 
      will be added.
    inputBinding:
      position: 101
      prefix: --convert-rt
  - id: db
    type: File
    doc: Sqlite database that contains the results from the previous steps.
    inputBinding:
      position: 101
      prefix: --db
  - id: intensity_matrix
    type:
      - 'null'
      - File
    doc: Tab-delimited intensity matrix.
    inputBinding:
      position: 101
      prefix: --intensity-matrix
  - id: ndigits_mz
    type:
      - 'null'
      - int
    doc: Digits after the decimal point for m/z values.
    inputBinding:
      position: 101
      prefix: --ndigits-mz
  - id: peaklist
    type: File
    doc: Tab-delimited peaklist
    inputBinding:
      position: 101
      prefix: --peaklist
  - id: sep
    type: string
    doc: Values on each line of the output are separated by this character.
    inputBinding:
      position: 101
      prefix: --sep
  - id: single_column
    type:
      - 'null'
      - boolean
    doc: Concatenate the annotations for each spectral feature and keep seperate
      columns for molecular formula, adduct, name, etc.
    inputBinding:
      position: 101
      prefix: --single-column
  - id: single_row
    type:
      - 'null'
      - boolean
    doc: Concatenate the annotations for each spectral feature and represent in 
      a single row.
    inputBinding:
      position: 101
      prefix: --single-row
outputs:
  - id: output
    type: File
    doc: Output file for the summary
    outputBinding:
      glob: $(inputs.output)
  - id: pdf
    type:
      - 'null'
      - File
    doc: Output pdf file for the summary plots
    outputBinding:
      glob: $(inputs.pdf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0
