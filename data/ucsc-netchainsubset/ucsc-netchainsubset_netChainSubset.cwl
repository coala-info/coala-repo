cwlVersion: v1.2
class: CommandLineTool
baseCommand: netChainSubset
label: ucsc-netchainsubset_netChainSubset
doc: "Create chain file with subset of chains that appear in the net\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_net
    type: File
    doc: Input net file
    inputBinding:
      position: 1
  - id: input_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 2
  - id: out_chain
    type: string
    doc: Output chain file
    inputBinding:
      position: 3
  - id: skip_missing
    type:
      - 'null'
      - boolean
    doc: skip chains that are not found instead of generating an error. Useful 
      if chains have been filtered.
    inputBinding:
      position: 103
      prefix: -skipMissing
  - id: split_on_insert
    type:
      - 'null'
      - boolean
    doc: Split chain when get an insertion of another chain
    inputBinding:
      position: 103
      prefix: -splitOnInsert
  - id: type
    type:
      - 'null'
      - string
    doc: Restrict output to particular type in net file
    inputBinding:
      position: 103
      prefix: -type=
      separate: false
  - id: whole_chains
    type:
      - 'null'
      - boolean
    doc: Write entire chain references by net, don't split when a high-level net
      is encoundered. This is useful when nets have been filtered.
    inputBinding:
      position: 103
      prefix: -wholeChains
  - id: gap_output_file_path
    type:
      - 'null'
      - string
    doc: =gap.tab - Output gap sizes to file
    inputBinding:
      position: 104
      prefix: -gapOut=
      separate: false
outputs:
  - id: output_chain
    type: File
    doc: Output chain file
    outputBinding:
      glob: '$(inputs.out_chain)'
  - id: gap_output_file
    type:
      - 'null'
      - File
    doc: Output gap sizes to file
    outputBinding:
      glob: $(inputs.gap_output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-netchainsubset:482--h0b57e2e_0
