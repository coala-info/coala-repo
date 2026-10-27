cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vseqselect
label: vmatch_vseqselect
doc: "Select sequences from a Vmatch index and write them in FASTA format.\n\nTool homepage: http://www.vmatch.de/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.index_files)
inputs:
  - id: minlength
    type:
      - 'null'
      - int
    doc: "specify the minimal length of the sequences to be selected"
    inputBinding:
      position: 101
      prefix: -minlength
  - id: maxlength
    type:
      - 'null'
      - int
    doc: "specify the maximal length of the sequences to be selected"
    inputBinding:
      position: 101
      prefix: -maxlength
  - id: randomnum
    type:
      - 'null'
      - int
    doc: "specify the number of random sequences to be selected"
    inputBinding:
      position: 101
      prefix: -randomnum
  - id: randomlength
    type:
      - 'null'
      - int
    doc: "specify the minimal total length of the random sequences to be selected"
    inputBinding:
      position: 101
      prefix: -randomlength
  - id: seqnum
    type:
      - 'null'
      - File
    doc: "select the sequences with numbers given in filename"
    inputBinding:
      position: 101
      prefix: -seqnum
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
stdout: vmatch_vseqselect.out
