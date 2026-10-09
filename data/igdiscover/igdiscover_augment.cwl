cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - augment
label: igdiscover_augment
doc: "Augment AIRR-formatted IgBLAST output with extra IgDiscover-specific columns and fill in the CDR3 columns. The augmented table is written to standard output.\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: database
    type: Directory
    doc: "Database directory with V.fasta, D.fasta, J.fasta."
    inputBinding:
      position: 1
  - id: table
    type: File
    doc: "AIRR rearrangement table"
    inputBinding:
      position: 2
  - id: sequence_type
    type: ['null', string]
    doc: "Sequence type: Ig or TCR (default Ig)"
    inputBinding:
      position: 3
      prefix: --sequence-type
  - id: rename
    type: ['null', string]
    doc: "Rename reads to PREFIXseqN (where N is a number starting at 1)"
    inputBinding:
      position: 3
      prefix: --rename
  - id: stats_path
    type: ['null', string]
    doc: "Write statistics in JSON format to FILE"
    inputBinding:
      position: 4
      prefix: --stats
outputs:
  - id: stdout
    type: stdout
    doc: "Augmented AIRR table"
  - id: stats
    type: ['null', File]
    doc: "Statistics in JSON format"
    outputBinding:
      glob: $(inputs.stats_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
stdout: igdiscover_augment.out
