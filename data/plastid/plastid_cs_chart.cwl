cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cs
  - chart
label: plastid_cs_chart
doc: 'Make charts of the output of cs count.


  Tool homepage: https://github.com/joshuagryphon/plastid'
inputs:
  - id: gene_list
    type:
      - 'null'
      - File
    doc: Optional file listing regions (genes or transcripts) to chart
    inputBinding:
      position: 1
  - id: outbase
    type: string
    doc: Basename for output files
    inputBinding:
      position: 2
  - id: infiles
    type:
      - 'null'
      - type: array
        items: File
    doc: input files, made by 'count' subprogram
    inputBinding:
      position: 101
      prefix: --in
  - id: bins
    type:
      - 'null'
      - type: array
        items: int
    doc: Bins into which features are partitioned based on counts
    inputBinding:
      position: 101
      prefix: --bins
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Regions to compare (default: exon, utr5, cds, utr3)'
    inputBinding:
      position: 101
      prefix: --regions
  - id: metrics
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Metrics to compare (default: rpkm, reads)'
    inputBinding:
      position: 101
      prefix: --metrics
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all warning messages. Cannot use with '-v'.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity. With ''-v'', show every warning. With ''-vv'', turn warnings into exceptions. Cannot use with ''-q''. (Default: show each type of warning once)'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: figformat
    type:
      - 'null'
      - string
    doc: 'File format for figure(s); Default: png)'
    inputBinding:
      position: 101
      prefix: --figformat
  - id: figsize
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Figure width and height, in inches. (Default: use matplotlibrc params)'
    inputBinding:
      position: 101
      prefix: --figsize
  - id: title
    type:
      - 'null'
      - string
    doc: Base title for plot(s).
    inputBinding:
      position: 101
      prefix: --title
  - id: cmap
    type:
      - 'null'
      - string
    doc: 'Matplotlib color map from which palette will be made (e.g. ''Blues'',''autumn'',''Set1''; default: use colors from ``--stylesheet`` if given, or color cycle in matplotlibrc)'
    inputBinding:
      position: 101
      prefix: --cmap
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'Figure resolution (Default: 150)'
    inputBinding:
      position: 101
      prefix: --dpi
  - id: stylesheet
    type:
      - 'null'
      - string
    doc: Use this matplotlib stylesheet instead of matplotlibrc params
    inputBinding:
      position: 101
      prefix: --stylesheet
outputs:
  - id: outputs
    type:
      type: array
      items: File
    doc: Files written with the given output basename
    outputBinding:
      glob: $(inputs.outbase)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
