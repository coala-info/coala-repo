cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapCounter
label: hmmcopy_mapCounter
doc: "Calculate the average mappability of non-overlapping windows from a BigWig file and write it in WIG (or SEG) format to standard output.\n\nTool homepage: http://compbio.bccrc.ca/software/hmmcopy/"
inputs:
  - id: bigwig_file
    type: File
    doc: "BigWig mappability file"
    inputBinding:
      position: 2
  - id: seg
    type:
      - 'null'
      - boolean
    doc: "Outputs in SEG format"
    inputBinding:
      position: 1
      prefix: --seg
  - id: window
    type:
      - 'null'
      - int
    doc: "Specify the size of non-overlapping windows [1000]"
    inputBinding:
      position: 1
      prefix: --window
  - id: list
    type:
      - 'null'
      - boolean
    doc: "List all chromosomes in the input file"
    inputBinding:
      position: 1
      prefix: --list
  - id: chromosome
    type:
      - 'null'
      - string
    doc: "Specify the entries and order of sequences to analyze [ALL], a comma-delimited list (no spaces)"
    inputBinding:
      position: 1
      prefix: --chromosome
outputs:
  - id: map_wig
    type: stdout
    doc: Mappability per window (WIG, or SEG with --seg)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
stdout: hmmcopy_mapCounter.wig
