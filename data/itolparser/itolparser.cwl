cwlVersion: v1.2
class: CommandLineTool
baseCommand: itolparser
label: itolparser
doc: "Generate iTOL files from tables\n\nTool homepage: https://github.com/boasvdp/itolparser"
inputs:
  - id: continuous
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of columns to parse as continuous
    inputBinding:
      position: 101
      prefix: --continuous
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Force input parsing as .csv file
    inputBinding:
      position: 101
      prefix: --csv
  - id: ignore
    type:
      - 'null'
      - type: array
        items: string
    doc: List of columns to ignore
    inputBinding:
      position: 101
      prefix: --ignore
  - id: input
    type: File
    doc: Input table with categorical metadata in .tsv format unless otherwise 
      specified
    inputBinding:
      position: 101
      prefix: --input
  - id: margin
    type:
      - 'null'
      - int
    doc: Size of margin specified in iTOL file
    inputBinding:
      position: 101
      prefix: --margin
  - id: maxcategories
    type:
      - 'null'
      - int
    doc: Maximum number of categories to not get assigned to "other"
    inputBinding:
      position: 101
      prefix: --maxcategories
  - id: palette
    type:
      - 'null'
      - string
    doc: Color palette to use for continuous columns
    inputBinding:
      position: 101
      prefix: --palette
  - id: stripwidth
    type:
      - 'null'
      - int
    doc: Strip width specified in iTOL file
    inputBinding:
      position: 101
      prefix: --stripwidth
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Force input parsing as .tsv file
    inputBinding:
      position: 101
      prefix: --tsv
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory to write files to
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itolparser:0.2.1--pyh7cba7a3_0
