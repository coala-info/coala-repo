cwlVersion: v1.2
class: CommandLineTool
baseCommand: header
label: mimodd_header
doc: "Add or modify header information in BAM/SAM/CRAM files.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: comment
    type:
      - 'null'
      - type: array
        items: string
    doc: an arbitrary number of one-line comment strings
    inputBinding:
      position: 101
      prefix: --co
  - id: relaxed
    type:
      - 'null'
      - boolean
    doc: do not enforce a sample name to be specified for every read group
    inputBinding:
      position: 101
      prefix: --relaxed
  - id: rg_cn
    type:
      - 'null'
      - type: array
        items: string
    doc: one sequencing center name per read group
    inputBinding:
      position: 101
      prefix: --rg-cn
  - id: rg_ds
    type:
      - 'null'
      - type: array
        items: string
    doc: one description line per read group
    inputBinding:
      position: 101
      prefix: --rg-ds
  - id: rg_dt
    type:
      - 'null'
      - type: array
        items: string
    doc: date runs were produced (YYYY-MM-DD); one date per read group
    inputBinding:
      position: 101
      prefix: --rg-dt
  - id: rg_id
    type:
      - 'null'
      - type: array
        items: string
    doc: one or more unique read group identifiers
    inputBinding:
      position: 101
      prefix: --rg-id
  - id: rg_lb
    type:
      - 'null'
      - type: array
        items: string
    doc: library identifier for each read group
    inputBinding:
      position: 101
      prefix: --rg-lb
  - id: rg_pi
    type:
      - 'null'
      - type: array
        items: int
    doc: predicted median insert size for the reads of each read group
    inputBinding:
      position: 101
      prefix: --rg-pi
  - id: rg_pl
    type:
      - 'null'
      - type: array
        items: string
    doc: sequencing platform/technology used to produce each read group
    inputBinding:
      position: 101
      prefix: --rg-pl
  - id: rg_pu
    type:
      - 'null'
      - type: array
        items: string
    doc: platform unit, e.g., flowcell barcode or slide identifier, for each 
      read group
    inputBinding:
      position: 101
      prefix: --rg-pu
  - id: rg_sm
    type:
      - 'null'
      - type: array
        items: string
    doc: one sample name per read group identifier
    inputBinding:
      position: 101
      prefix: --rg-sm
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect the output to the specified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
