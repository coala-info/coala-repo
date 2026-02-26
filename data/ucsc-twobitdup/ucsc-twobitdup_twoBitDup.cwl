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
      - Directory
    doc: place to put cache for remote bigBed/bigWigs
    inputBinding:
      position: 102
      prefix: -udcDir
outputs:
  - id: key_list
    type:
      - 'null'
      - File
    doc: 'file to write a key list, two columns: md5sum and sequenceName'
    outputBinding:
      glob: $(inputs.key_list)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobitdup:482--h0b57e2e_0
