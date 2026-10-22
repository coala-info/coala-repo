cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - syngap
  - evi
label: syngap_evi
doc: "Calculate EVI (Expression Variation Index) for gene pairs.\n\nTool homepage:
  https://github.com/yanyew/SynGAP"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: The format of output figure
    inputBinding:
      position: 101
      prefix: --format
  - id: genepair
    type: File
    doc: The genepair file (tab-divided) for EVI counting
    inputBinding:
      position: 101
      valueFrom: $(self.basename)
      prefix: --genepair
  - id: sp1exp
    type: File
    doc: The expression file (tab-divided) for species1
    inputBinding:
      position: 101
      valueFrom: $(self.basename)
      prefix: --sp1exp
  - id: sp2exp
    type: File
    doc: The expression file (tab-divided) for species2
    inputBinding:
      position: 101
      valueFrom: $(self.basename)
      prefix: --sp2exp
  - id: weight
    type:
      - 'null'
      - string
    doc: The weight of three indexes in EVI calulating (ML:FC:PCC)
    inputBinding:
      position: 101
      prefix: --weight
outputs:
  - id: evi_tables
    type:
      type: array
      items: File
    doc: EVI result tables and thresholds written next to the genepair file
    outputBinding:
      glob:
        - $(inputs.genepair.basename).*.xls
        - $(inputs.genepair.basename).*.txt
  - id: evi_figures
    type:
      type: array
      items: File
    doc: EVI figures written next to the genepair file
    outputBinding:
      glob:
        - $(inputs.genepair.basename).*.pdf
        - $(inputs.genepair.basename).*.png
        - $(inputs.genepair.basename).*.svg
        - $(inputs.genepair.basename).*.jpg
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genepair)
        writable: true
      - entry: $(inputs.sp1exp)
        writable: true
      - entry: $(inputs.sp2exp)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syngap:1.2.5--py312hdfd78af_0
stdout: syngap_evi.out
