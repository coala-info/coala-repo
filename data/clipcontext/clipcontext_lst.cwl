cwlVersion: v1.2
class: CommandLineTool
baseCommand: clipcontext_lst
label: clipcontext_lst
doc: "Accept only transcripts with length >= --min-len (default: False)\n\nTool homepage:
  https://github.com/BackofenLab/CLIPcontext"
inputs:
  - id: add_infos
    type:
      - 'null'
      - boolean
    doc: Add additional information columns (gene ID, TSL, length) to output 
      file
    inputBinding:
      position: 101
      prefix: --add-infos
  - id: gtf
    type: File
    doc: 'Genomic annotations (hg38) GTF file (.gtf or .gtf.gz) (NOTE: tested with
      Ensembl GTF files, expects transcript support level (TSL) information)'
    inputBinding:
      position: 101
      prefix: --gtf
  - id: min_len
    type:
      - 'null'
      - int
    doc: Accept only transcripts with length >= --min-len
    inputBinding:
      position: 101
      prefix: --min-len
  - id: out
    type: string
    doc: Output transcript IDs list file
    inputBinding:
      position: 101
      prefix: --out
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Accept only transcripts with transcript support level (TSL) 1-5
    inputBinding:
      position: 101
      prefix: --strict
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipcontext:0.7--py_0
stdout: clipcontext_lst.out
