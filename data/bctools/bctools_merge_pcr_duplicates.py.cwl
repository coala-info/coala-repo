cwlVersion: v1.2
class: CommandLineTool
baseCommand: merge_pcr_duplicates.py
label: bctools_merge_pcr_duplicates.py
doc: "Merge PCR duplicates according to random barcode library. All alignments with
  same outer coordinates and barcode will be merged into a single crosslinking event.\n\
  \nBarcodes containing uncalled base 'N' are removed.\n\nTool homepage: https://github.com/dmaticzka/bctools"
inputs:
  - id: alignments
    type: File
    doc: Path to bed6 file containing alignments.
    inputBinding:
      position: 1
  - id: bclib
    type: File
    doc: Path to fastq barcode library.
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print lots of debugging information
    inputBinding:
      position: 103
      prefix: --debug
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: outfile
    type: File
    doc: Write results to this file.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
