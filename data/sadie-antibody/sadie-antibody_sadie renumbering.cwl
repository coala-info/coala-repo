cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sadie
  - renumbering
label: sadie-antibody_sadie renumbering
doc: "Renumber antibody sequences based on specified schemes and regions.\n\nTool
  homepage: https://sadie.jordanrwillis.com"
inputs:
  - id: allowed_chains
    type:
      - 'null'
      - string
    doc: A comma seperated list of species to align against
    default: H,K,L,A,B,G,D
    inputBinding:
      position: 101
      prefix: --allowed-chains
  - id: allowed_species
    type:
      - 'null'
      - string
    doc: A comma seperated list of species to align against
    default: human,mouse,rat,rabbit,rhesus,pig,alpaca,dog,cat
    inputBinding:
      position: 101
      prefix: --allowed-species
  - id: compress
    type:
      - 'null'
      - string
    doc: opitonal file compression on output
    inputBinding:
      position: 101
      prefix: --compress
  - id: file_format
    type:
      - 'null'
      - string
    doc: output file type format
    inputBinding:
      position: 101
      prefix: --file-format
  - id: query
    type:
      - 'null'
      - File
    doc: The input file can be compressed or uncompressed file of fasta
    inputBinding:
      position: 101
      prefix: --query
  - id: region
    type:
      - 'null'
      - string
    doc: The framework and cdr defition to use
    default: imgt
    inputBinding:
      position: 101
      prefix: --region
  - id: scheme
    type:
      - 'null'
      - string
    doc: The numbering scheme to use.
    default: imgt
    inputBinding:
      position: 101
      prefix: --scheme
  - id: seq
    type:
      - 'null'
      - string
    doc: The input seq
    inputBinding:
      position: 101
      prefix: --seq
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Vebosity level, ex. -vvvvv for debug level logging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: The output file, type is inferred from extensions
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
