cwlVersion: v1.2
class: CommandLineTool
baseCommand: STECFinder.py
label: stecfinder
doc: "STECFinder.py is a tool for identifying Shiga toxin-producing E. coli (STEC)
  strains.\n\nTool homepage: https://github.com/LanLab/STECFinder"
inputs:
  - id: check_dependencies
    type:
      - 'null'
      - boolean
    doc: check dependencies are installed
    default: false
    inputBinding:
      position: 101
      prefix: --check
  - id: cutoff
    type:
      - 'null'
      - float
    doc: minimum read coverage for gene to be called
    default: 10.0
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: gene_length_percentage
    type:
      - 'null'
      - float
    doc: percentage of gene length needed for positive call
    default: 50.0
    inputBinding:
      position: 101
      prefix: --length
  - id: h_depth_percentage
    type:
      - 'null'
      - float
    doc: When using reads as input the minimum depth percentage relative to 
      genome average for positive fliC gene call
    default: 1.0
    inputBinding:
      position: 101
      prefix: --h_depth
  - id: h_length_percentage
    type:
      - 'null'
      - float
    doc: percentage of fliC gene length needed for positive call
    default: 60.0
    inputBinding:
      position: 101
      prefix: --h_length
  - id: input_data
    type:
      type: array
      items: string
    doc: path/to/input_data
    inputBinding:
      position: 101
      prefix: -i
  - id: ipah_depth_percentage
    type:
      - 'null'
      - float
    doc: When using reads as input the minimum depth percentage relative to 
      genome average for positive ipaH gene call
    default: 1.0
    inputBinding:
      position: 101
      prefix: --ipaH_depth
  - id: ipah_length_percentage
    type:
      - 'null'
      - float
    doc: percentage of ipaH gene length needed for positive gene call
    default: 10.0
    inputBinding:
      position: 101
      prefix: --ipaH_length
  - id: o_depth_percentage
    type:
      - 'null'
      - float
    doc: When using reads as input the minimum depth percentage relative to 
      genome average for positive wz_ gene call
    default: 1.0
    inputBinding:
      position: 101
      prefix: --o_depth
  - id: o_length_percentage
    type:
      - 'null'
      - float
    doc: percentage of wz_ gene length needed for positive call
    default: 60.0
    inputBinding:
      position: 101
      prefix: --o_length
  - id: raw_reads
    type:
      - 'null'
      - boolean
    doc: Add flag if file is raw reads.
    default: false
    inputBinding:
      position: 101
      prefix: -r
  - id: sample_sheet
    type:
      - 'null'
      - File
    doc: Specify input via sample sheet. Sample sheet should be CSV with columns
      'read_1,read_2,unpaired'.
    inputBinding:
      position: 101
      prefix: --sample_sheet
  - id: show_hits
    type:
      - 'null'
      - boolean
    doc: shows detailed gene search results
    default: false
    inputBinding:
      position: 101
      prefix: --hits
  - id: stx_depth_percentage
    type:
      - 'null'
      - float
    doc: When using reads as input the minimum depth percentage relative to 
      genome average for positive stx gene call
    default: 1.0
    inputBinding:
      position: 101
      prefix: --stx_depth
  - id: stx_length_percentage
    type:
      - 'null'
      - float
    doc: percentage of stx gene length needed for positive gene call
    default: 10.0
    inputBinding:
      position: 101
      prefix: --stx_length
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    default: 4
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file to write to (if not used writes to stdout and tmp folder in
      current dir)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stecfinder:1.1.2--pyhdfd78af_0
