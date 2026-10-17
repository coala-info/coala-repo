cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnase_wig_tracks.py
label: pydnase_dnase_wig_tracks.py
doc: "Writes two WIG files with the cut information based on the regions in reads BED file and the reads in reads BAM file.\n\nTool homepage: https://github.com/jpiper/pyDNase"
inputs:
  - id: regions
    type: File
    doc: "BED file of the regions you want to write wig tracks for"
    inputBinding:
      position: 1
  - id: reads
    type: File
    doc: "The BAM file containing the read data"
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 2
  - id: fw_output
    type: string
    doc: "Path to write the forward reads wig track to"
    inputBinding:
      position: 3
  - id: rev_output
    type: string
    doc: "Path to write the reverse reads wig track to"
    inputBinding:
      position: 4
  - id: real
    type:
      - 'null'
      - boolean
    doc: "Report cuts on the negative strand as positive numbers instead of negative (default: False)."
    inputBinding:
      position: 10
      prefix: --real
  - id: atac
    type:
      - 'null'
      - boolean
    doc: "ATAC-seq mode (default: False)."
    inputBinding:
      position: 20
      prefix: -A
outputs:
  - id: fw_wig
    type: File
    doc: "Forward strand wig track."
    outputBinding:
      glob: $(inputs.fw_output)
  - id: rev_wig
    type: File
    doc: "Reverse strand wig track."
    outputBinding:
      glob: $(inputs.rev_output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydnase:0.3.0--py35_0
