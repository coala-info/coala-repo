cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - PathogenTrack
  - extract
label: pathogentrack_extract
doc: "extract and append barcode and UMI to the read2 name\n\nTool homepage: https://github.com/ncrna/PathogenTrack"
inputs:
  - id: barcode
    type:
      - 'null'
      - File
    doc: file name for valid barcodes (a file made by trim, stored in the project
      folder)
    inputBinding:
      position: 101
      prefix: --barcode
      valueFrom: "$(self ? self.basename : null)"
  - id: project_id
    type: string
    doc: project id to store output files
    inputBinding:
      position: 101
      prefix: --project_id
  - id: pattern
    type:
      - 'null'
      - string
    doc: barcode pattern, default="CCCCCCCCCCCCCCCCNNNNNNNNNN", please refer to
      umi_tools help manual
    inputBinding:
      position: 101
      prefix: --pattern
  - id: ignore_suffix
    type:
      - 'null'
      - boolean
    doc: ignore the read name suffixes, eg., /1 and /2 in the read are ignored,
      default is False
    inputBinding:
      position: 101
      prefix: --ignore_suffix
  - id: output
    type:
      - 'null'
      - string
    doc: file to output processed read to
    default: reads_barcoded.fq.gz
    inputBinding:
      position: 101
      prefix: --output
  - id: read1
    type: File
    doc: file name for Read1
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type: File
    doc: file name for Read2
    inputBinding:
      position: 101
      prefix: --read2
outputs:
  - id: reads_barcoded
    type: File
    doc: read2 with the cell barcode and UMI appended to the read name
    outputBinding:
      glob: $(inputs.project_id + '/' + inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.project_id)
        writable: true
        entry: "$({\"class\": \"Directory\", \"basename\": inputs.project_id, \"listing\": (inputs.barcode ? [inputs.barcode] : [])})"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
