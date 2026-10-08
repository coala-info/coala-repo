cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dsh-extract-uniprot-features
label: dsh-bio_extract-uniprot-features
doc: "extract protein features from UniProt XML format\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_uniprot_xml_path
    type: File
    doc: "input UniProt XML path, default stdin"
    inputBinding:
      position: 101
      prefix: --input-uniprot-xml-path
  - id: output_feature_file_path
    type: string
    doc: "output feature file, default stdout"
    inputBinding:
      position: 101
      prefix: --output-feature-file
outputs:
  - id: output_feature_file
    type:
      - 'null'
      - File
    doc: "output feature file, default stdout"
    outputBinding:
      glob: $(inputs.output_feature_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
