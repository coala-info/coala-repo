cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitDup
label: ucsc-twobitdup_twoBitDup
doc: "check to see if a twobit file has any identical sequences in it\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: file
    type: File
    doc: Input 2bit file
    inputBinding:
      position: 1
  - id: udc_dir
    type:
      - 'null'
      - string
    doc: place to put cache for remote bigBed/bigWigs
    inputBinding:
      position: 102
      prefix: -udcDir=
      separate: false
  - id: key_list_path
    type:
      - 'null'
      - string
    doc: 'file to write a key list, two columns: md5sum and sequenceName'
    inputBinding:
      position: 103
      prefix: -keyList=
      separate: false
outputs:
  - id: report
    type: stdout
    doc: Messages about identical sequences
  - id: key_list
    type:
      - 'null'
      - File
    doc: 'file to write a key list, two columns: md5sum and sequenceName'
    outputBinding:
      glob: $(inputs.key_list_path)
requirements:
  - class: InlineJavascriptRequirement
stdout: ucsc-twobitdup.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobitdup:482--h0b57e2e_0
