cwlVersion: v1.2
class: CommandLineTool
baseCommand: lexmapr
label: lexmapr
doc: "Map lexical terms to ontology IRIs and classify samples.\n\nTool homepage: https://github.com/LexMapr/lexmapr"
inputs:
  - id: input_file
    type: File
    doc: Input csv or tsv file
    inputBinding:
      position: 1
  - id: bucket
    type:
      - 'null'
      - boolean
    doc: Classify samples into pre-defined buckets
    inputBinding:
      position: 102
      prefix: --bucket
  - id: config
    type:
      - 'null'
      - File
    doc: Path to JSON file containing the IRI of ontologies to fetch terms from
    inputBinding:
      position: 102
      prefix: --config
  - id: full
    type:
      - 'null'
      - boolean
    doc: Full output format
    inputBinding:
      position: 102
      prefix: --full
  - id: no_cache
    type:
      - 'null'
      - boolean
    doc: Ignore or replace online cached resources, if there are any.
    inputBinding:
      position: 102
      prefix: --no-cache
  - id: profile
    type:
      - 'null'
      - string
    doc: "Pre-defined sets of command-line arguments for specialized purposes:\n \
      \                       \n                        * ifsac: \n              \
      \            * maps samples to food and environmental resources\n          \
      \                * classifies samples into ifsac labels\n                  \
      \        * outputs content to ``ifsac_output.tsv``"
    inputBinding:
      position: 102
      prefix: --profile
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lexmapr:0.7.1--py36h09cc20e_1
