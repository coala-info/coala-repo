cwlVersion: v1.2
class: CommandLineTool
baseCommand: merfishtools est-error-rates
label: merfishtools_est-error-rates
doc: "Estimate 0-1 and 1-0 error rates.\n\nTool homepage: https://merfishtools.github.io"
inputs:
  - id: tsv_file
    type: File
    doc: Path to codebook file.
    inputBinding:
      position: 1
  - id: raw_data
    type: string
    doc: 'Raw data containing molecule assignments to positions. If given as TSV file
      (ending on .tsv), the following columns are expected: cell, feature, readout.
      Otherwise, the official MERFISH binary format is expected.'
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merfishtools:1.5.0--py312h9d36253_3
stdout: merfishtools_est-error-rates.out
