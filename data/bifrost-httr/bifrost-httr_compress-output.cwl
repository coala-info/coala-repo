cwlVersion: v1.2
class: CommandLineTool
baseCommand: bifrost-httr compress-output
label: bifrost-httr_compress-output
doc: "Compress intermediate output into a single pandas DataFrame.\n\nTool homepage:
  https://github.com/seqera-services/bifrost-httr"
inputs:
  - id: cell_type
    type:
      - 'null'
      - string
    doc: Cell type name (as it appears in the HTTr meta data)
    inputBinding:
      position: 101
      prefix: --cell_type
  - id: fits_dir
    type: Directory
    doc: Directory containing probe .pkl files to process
    inputBinding:
      position: 101
      prefix: --fits-dir
  - id: no_compression
    type:
      - 'null'
      - boolean
    doc: Save output as plain JSON without compression
    inputBinding:
      position: 101
      prefix: --no-compression
  - id: seed
    type:
      - 'null'
      - int
    doc: Optional random seed for reproducibility
    inputBinding:
      position: 101
      prefix: --seed
  - id: test_substance
    type:
      - 'null'
      - string
    doc: Test substance name (as it appears in the HTTr meta data)
    inputBinding:
      position: 101
      prefix: --test_substance
outputs:
  - id: output
    type: File
    doc: Path to the output json
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bifrost-httr:0.5.0--pyhdfd78af_0
