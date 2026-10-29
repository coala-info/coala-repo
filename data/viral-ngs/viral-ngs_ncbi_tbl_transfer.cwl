cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ncbi.py
  - tbl_transfer
label: viral-ngs_ncbi_tbl_transfer
doc: "This function takes an NCBI TBL file describing features on a genome (genes, etc) and transfers them to a new genome.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: ref_fasta
    type: File
    doc: "Input sequence of reference genome"
    inputBinding:
      position: 1
  - id: ref_tbl
    type: File
    doc: "Input reference annotations (NCBI TBL format)"
    inputBinding:
      position: 2
  - id: alt_fasta
    type: File
    doc: "Input sequence of new genome"
    inputBinding:
      position: 3
  - id: out_tbl
    type: string
    doc: "Output file with transferred annotations"
    inputBinding:
      position: 4
  - id: oob_clip
    type:
      - 'null'
      - boolean
    doc: "Out of bounds feature behavior. False: drop all features that are completely or partly out of bounds True: drop all features completely out of bounds but truncate any features that are partly out of bounds"
    inputBinding:
      position: 20
      prefix: --oob_clip
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: out_tbl_file
    type: File
    doc: "Output file written to out_tbl"
    outputBinding:
      glob: $(inputs.out_tbl)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
