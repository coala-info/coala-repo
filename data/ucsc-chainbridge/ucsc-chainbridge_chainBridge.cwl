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
  - id: linear_gap
    type:
      - 'null'
      - string
    doc: Specify type of linearGap to use. loose is chicken/human linear gap 
      costs. medium is mouse/human linear gap costs. Or specify a piecewise 
      linearGap tab delimited file.
    inputBinding:
      position: 104
      prefix: -linearGap
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum size of double-sided gap to try to bridge
    inputBinding:
      position: 104
      prefix: -maxGap
  - id: score_scheme
    type:
      - 'null'
      - File
    doc: Read the scoring matrix from a blastz-format file
    inputBinding:
      position: 104
      prefix: -scoreScheme
outputs:
  - id: output_chain
    type: File
    doc: Output chain file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainbridge:377--h199ee4e_0
