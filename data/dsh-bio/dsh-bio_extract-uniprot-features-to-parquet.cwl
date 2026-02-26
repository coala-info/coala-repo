cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-extract-uniprot-features-to-parquet
label: dsh-bio_extract-uniprot-features-to-parquet
doc: "Extracts features from UniProt XML files and saves them to a Parquet file.\n\
  \nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: about
    type:
      - 'null'
      - boolean
    doc: display about message
    inputBinding:
      position: 101
      prefix: --about
  - id: input_uniprot_xml_path
    type:
      - 'null'
      - File
    doc: input UniProt XML path
    default: stdin
    inputBinding:
      position: 101
      prefix: --input-uniprot-xml-path
  - id: row_group_size
    type:
      - 'null'
      - int
    doc: row group size
    default: 122880
    inputBinding:
      position: 101
      prefix: --row-group-size
outputs:
  - id: output_feature_file
    type: File
    doc: output feature Parquet file
    outputBinding:
      glob: $(inputs.output_feature_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
