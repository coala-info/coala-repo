cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainMergeSort
label: ucsc-chainmergesort
doc: "Combine sorted chain files into a larger sorted file. Output goes to standard
  output.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.list_member_files || [])
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Sorted chain file(s) to merge
    inputBinding:
      position: 2
  - id: save_id
    type: ['null', boolean]
    doc: Keep the existing chain ids
    inputBinding:
      position: 1
      prefix: -saveId
  - id: input_list
    type: ['null', File]
    doc: File that contains a list of input chain files (one name per line)
    inputBinding:
      position: 1
      prefix: -inputList=
      separate: false
  - id: list_member_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Chain files named in the input_list file; they are staged in the working
      directory so the names in the list resolve
  - id: temp_dir
    type: ['null', string]
    doc: Directory with space for temporary sorting data (default ./)
    inputBinding:
      position: 1
      prefix: -tempDir=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Merged sorted chain file
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainmergesort:482--h0b57e2e_0
stdout: ucsc-chainmergesort.out
