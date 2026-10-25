cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToChain
label: ucsc-psltochain
doc: "Convert psl records to chain records.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_in
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 10
  - id: chain_out
    type: string
    doc: Output chain file name.
    inputBinding:
      position: 11
  - id: fix_strand
    type:
      - 'null'
      - boolean
    doc: Reverse-complement negative target strand PSLs.
    inputBinding:
      position: 1
      prefix: -fixStrand
  - id: ignore
    type:
      - 'null'
      - boolean
    doc: Ignore PSL records with negative target strand rather than exiting.
    inputBinding:
      position: 2
      prefix: -ignore
outputs:
  - id: chain_out_file
    type: File
    doc: Output chain file.
    outputBinding:
      glob: $(inputs.chain_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltochain:482--h0b57e2e_0
