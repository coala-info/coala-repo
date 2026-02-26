cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-bio_extract-uniprot-features
label: dsh-bio_extract-uniprot-features
doc: "Extracts features from UniProt XML entries.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: uniprot_xml_file
    type: File
    doc: Path to the UniProt XML file.
    inputBinding:
      position: 1
  - id: feature_types
    type:
      - 'null'
      - type: array
        items: string
    doc: A comma-separated list of feature types to extract (e.g., 
      'DOMAIN,REGION,MOTIF'). If not specified, all feature types will be 
      extracted.
    inputBinding:
      position: 102
      prefix: --feature-types
  - id: include_comments
    type:
      - 'null'
      - boolean
    doc: Include comments in the output.
    inputBinding:
      position: 102
      prefix: --include-comments
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to the output file for extracted features. If not specified, 
      features will be printed to standard output.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
