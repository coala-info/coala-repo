cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vsubseqselect
label: vmatch_vsubseqselect
doc: "Select substrings of the sequences of a Vmatch index and write them in FASTA format.\n\nTool homepage: http://www.vmatch.de/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files)
inputs:
  - id: minlength
    type:
      - 'null'
      - int
    doc: "specify the minimal length of the substrings to be selected"
    inputBinding:
      position: 101
      prefix: -minlength
  - id: maxlength
    type:
      - 'null'
      - int
    doc: "specify the maximal length of the substrings to be selected"
    inputBinding:
      position: 101
      prefix: -maxlength
  - id: snum
    type:
      - 'null'
      - int
    doc: "specify the number of substrings to be selected (use together with -minlength and -maxlength)"
    inputBinding:
      position: 101
      prefix: -snum
  - id: range
    type:
      - 'null'
      - type: array
        items: int
    doc: "specify the first and last position of the substring to be selected (two integers)"
    inputBinding:
      position: 101
      prefix: -range
  - id: seq
    type:
      - 'null'
      - string
    doc: "specify length, number, and relative position of the substring to be selected"
    inputBinding:
      position: 101
      prefix: -seq
  - id: index_files
    type: File[]
    doc: "Index files written by mkvtree (staged in the working directory so the index name resolves)"
  - id: index_name
    type: string
    doc: "Name of the index (the mkvtree -indexname value)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_vsubseqselect.out
