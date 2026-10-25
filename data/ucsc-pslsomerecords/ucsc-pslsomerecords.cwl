cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSomeRecords
label: ucsc-pslsomerecords
doc: "Extract multiple PSL records whose qName is in a list file.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: psl_in
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 10
  - id: list_file
    type: File
    doc: File with a qName (RNA accession usually) on each line. With -tToo it has
      two columns, qName and tName.
    inputBinding:
      position: 11
  - id: psl_out
    type: string
    doc: Output PSL file name.
    inputBinding:
      position: 12
  - id: not_in_list
    type:
      - 'null'
      - boolean
    doc: Include a PSL record if its name is NOT in the list.
    inputBinding:
      position: 1
      prefix: -not
  - id: t_too
    type:
      - 'null'
      - boolean
    doc: The list file is two column, qName and tName. Only records matching on
      both q and t are output.
    inputBinding:
      position: 2
      prefix: -tToo
outputs:
  - id: psl_out_file
    type: File
    doc: Output PSL file with the extracted records.
    outputBinding:
      glob: $(inputs.psl_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslsomerecords:482--h0b57e2e_0
