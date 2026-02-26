cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainSplit
label: ucsc-chainsplit_chainSplit
doc: "Split chains by target or query sequence\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: out_dir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 1
  - id: in_chains
    type:
      type: array
      items: File
    doc: Input chain file(s)
    inputBinding:
      position: 2
  - id: lump_files
    type:
      - 'null'
      - int
    doc: Lump together so have only N split files
    inputBinding:
      position: 103
      prefix: --lump
  - id: split_on_query
    type:
      - 'null'
      - boolean
    doc: Split on query (default is on target)
    default: false
    inputBinding:
      position: 103
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainsplit:482--h0b57e2e_0
stdout: ucsc-chainsplit_chainSplit.out
