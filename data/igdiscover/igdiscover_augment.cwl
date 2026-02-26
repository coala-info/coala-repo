cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - augment
label: igdiscover_augment
doc: "Augment AIRR-formatted IgBLAST output with extra IgDiscover-specific columns\n\
  \nAlso, fill in the CDR3 columns\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: database
    type: Directory
    doc: Database directory with V.fasta, D.fasta, J.fasta.
    inputBinding:
      position: 1
  - id: table
    type: File
    doc: AIRR rearrangement table
    inputBinding:
      position: 2
  - id: rename
    type:
      - 'null'
      - string
    doc: "Rename reads to PREFIXseqN (where N is a number\n                      \
      \  starting at 1)"
    inputBinding:
      position: 103
      prefix: --rename
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: Sequence type.
    default: Ig
    inputBinding:
      position: 103
      prefix: --sequence-type
outputs:
  - id: stats
    type:
      - 'null'
      - File
    doc: Write statistics in JSON format to FILE
    outputBinding:
      glob: $(inputs.stats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
