cwlVersion: v1.2
class: CommandLineTool
baseCommand: primerclip
label: primerclip
doc: "Trim PCR primer sequences from aligned reads\n\nTool homepage: https://github.com/swiftbiosciences/primerclip"
inputs:
  - id: primer_coords_infile
    type: File
    doc: Primer coordinates input file
    inputBinding:
      position: 1
  - id: sam_infile
    type: File
    doc: SAM input file
    inputBinding:
      position: 2
  - id: bedpe
    type:
      - 'null'
      - boolean
    doc: add this switch to use BEDPE coordinate input format (default format is
      master file)
    inputBinding:
      position: 103
      prefix: --bedpe
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: add this switch to trim primers from single-end alignments
    inputBinding:
      position: 103
      prefix: --single-end
outputs:
  - id: output_sam_filename
    type: File
    doc: Output SAM filename
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primerclip:0.3.8--0
