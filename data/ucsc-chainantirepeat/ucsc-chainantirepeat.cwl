cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainAntiRepeat
label: ucsc-chainantirepeat
doc: "Get rid of chains that are primarily the results of repeats and degenerate
  DNA.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: target_nib_dir_or_2bit
    type: File
    doc: Target sequence, a 2bit file
    inputBinding:
      position: 1
  - id: query_nib_dir_or_2bit
    type: File
    doc: Query sequence, a 2bit file
    inputBinding:
      position: 2
  - id: in_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 3
  - id: out_chain
    type: string
    doc: Name of the output chain file
    inputBinding:
      position: 4
  - id: min_score
    type: ['null', int]
    doc: Minimum score (after repeat stuff) to pass
    inputBinding:
      position: 5
      prefix: -minScore=
      separate: false
  - id: no_check_score
    type: ['null', int]
    doc: Score that will pass without checks (speed tweak)
    inputBinding:
      position: 5
      prefix: -noCheckScore=
      separate: false
outputs:
  - id: output_chain
    type: File
    doc: Output chain file
    outputBinding:
      glob: $(inputs.out_chain)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainantirepeat:482--h0b57e2e_0
