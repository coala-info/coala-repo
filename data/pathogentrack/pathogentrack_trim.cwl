cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PathogenTrack
  - trim
label: pathogentrack_trim
doc: "trim -1 at the end of barcode\n\nTool homepage: https://github.com/ncrna/PathogenTrack"
inputs:
  - id: barcode
    type: File
    doc: file name for raw barcodes from cellranger, decompress it before use
    inputBinding:
      position: 101
      prefix: --barcode
  - id: project_id
    type: string
    doc: project id to store output files
    inputBinding:
      position: 101
      prefix: --project_id
  - id: output
    type:
      - 'null'
      - string
    doc: file to output barcodes to, default is barcodes.tsv
    default: barcodes.tsv
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: barcodes
    type: File
    doc: barcodes with the trailing -1 removed
    outputBinding:
      glob: $(inputs.project_id + '/' + inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
