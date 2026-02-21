cwlVersion: v1.2
class: CommandLineTool
baseCommand: compalignp
label: compalignp
doc: "Compute fractional \"identity\" between trusted alignment and test alignment.
  Identity of the multiple sequence alignments is defined as the averaged identity
  over all N(N-1)/2 pairwise alignments.\n\nTool homepage: http://www.biophys.uni-duesseldorf.de/bralibase/"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode
    inputBinding:
      position: 101
      prefix: -d
  - id: reference_msa
    type: File
    doc: Reference multiple sequence alignment (trusted alignment)
    inputBinding:
      position: 101
      prefix: -r
  - id: test_msa
    type: File
    doc: Test multiple sequence alignment
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/compalignp:1.0--0
stdout: compalignp.out
