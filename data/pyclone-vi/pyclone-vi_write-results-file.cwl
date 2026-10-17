cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyclone-vi
  - write-results-file
label: pyclone-vi_write-results-file
doc: "Write the results of a fitted model to file.\n\nTool homepage:
  https://github.com/Roth-Lab/pyclone-vi"
inputs:
  - id: in_file
    type: File
    doc: Path to HDF5 format file produced by the `fit` command.
    inputBinding:
      position: 1
      prefix: --in-file
  - id: out_file
    type: string
    doc: Path to where results will be written in tsv format.
    inputBinding:
      position: 1
      prefix: --out-file
  - id: compress
    type:
      - 'null'
      - boolean
    doc: If the output file should be compressed using gzip.
    inputBinding:
      position: 1
      prefix: --compress
outputs:
  - id: results_tsv
    type: File
    doc: Results table in tsv format (gzip compressed with --compress).
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyclone-vi:0.2.0--pyhdfd78af_0
