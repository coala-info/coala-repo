cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainBridge
label: ucsc-chainbridge_chainBridge
doc: "Attempt to extend alignments through double-sided gaps of similar size\n\nTool
  homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: input_chain
    type: File
    doc: Input chain file
    inputBinding:
      position: 1
  - id: target_2bit
    type: File
    doc: Target 2bit file
    inputBinding:
      position: 2
  - id: query_2bit
    type: File
    doc: Query 2bit file
    inputBinding:
      position: 3
  - id: out_chain
    type: string
    doc: Output chain file
    inputBinding:
      position: 4
  - id: linear_gap
    type:
      - 'null'
      - string
    doc: Specify type of linearGap to use. loose is chicken/human linear gap 
      costs. medium is mouse/human linear gap costs. Or specify a piecewise 
      linearGap tab delimited file.
    inputBinding:
      position: 104
      prefix: -linearGap=
      separate: false
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum size of double-sided gap to try to bridge
    inputBinding:
      position: 104
      prefix: -maxGap=
      separate: false
  - id: score_scheme
    type:
      - 'null'
      - File
    doc: Read the scoring matrix from a blastz-format file
    inputBinding:
      position: 104
      prefix: -scoreScheme=
      separate: false
outputs:
  - id: output_chain
    type: File
    doc: Output chain file
    outputBinding:
      glob: '$(inputs.out_chain)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainbridge:377--h199ee4e_0
