cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biom
  - export-metadata
label: biom-format_export_metadata
doc: "Export metadata as TSV.\n\nTool homepage: http://www.biom-format.org"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_fp
    type: File
    doc: The input BIOM table
    inputBinding:
      position: 101
      prefix: --input-fp
  - id: sample_metadata_fp
    type:
      - 'null'
      - string
    doc: The sample metadata output file.
    inputBinding:
      position: 101
      prefix: --sample-metadata-fp
  - id: observation_metadata_fp
    type:
      - 'null'
      - string
    doc: The observation metadata output file.
    inputBinding:
      position: 101
      prefix: --observation-metadata-fp
outputs:
  - id: sample_metadata
    type:
      - 'null'
      - File
    doc: The sample metadata TSV
    outputBinding:
      glob: '$(inputs.sample_metadata_fp ? inputs.sample_metadata_fp : [])'
  - id: observation_metadata
    type:
      - 'null'
      - File
    doc: The observation metadata TSV
    outputBinding:
      glob: '$(inputs.observation_metadata_fp ? inputs.observation_metadata_fp : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biom-format:2.1.15
