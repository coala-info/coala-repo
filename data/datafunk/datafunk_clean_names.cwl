cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - clean_names
label: datafunk_clean_names
doc: "Cleans trait names in a metadata file.\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: input_metadata
    type: File
    doc: Path to the input metadata CSV file.
    inputBinding:
      position: 101
      prefix: --input_metadata
  - id: trait
    type: string
    doc: The name of the trait column to clean.
    inputBinding:
      position: 101
      prefix: --trait
outputs:
  - id: output_metadata
    type: File
    doc: Path to save the cleaned metadata CSV file.
    outputBinding:
      glob: $(inputs.output_metadata)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
