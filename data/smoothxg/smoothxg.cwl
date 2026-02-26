cwlVersion: v1.2
class: CommandLineTool
baseCommand: smoothxg
label: smoothxg
doc: "Linearize and smooth a variation graph using partial order alignment (POA).\n\
  \nTool homepage: https://github.com/pangenome/smoothxg"
inputs:
  - id: consensus_spec
    type:
      - 'null'
      - string
    doc: Consensus specification.
    inputBinding:
      position: 101
      prefix: --consensus-spec
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Maximum path difference allowed for a path to be included in a block.
    inputBinding:
      position: 101
      prefix: --epsilon
  - id: gfa_in
    type: File
    doc: Input GFA file to smooth.
    inputBinding:
      position: 101
      prefix: --gfa
  - id: max_path_diff
    type:
      - 'null'
      - int
    doc: Maximum path difference for POA.
    inputBinding:
      position: 101
      prefix: --max-path-diff
  - id: path_weight
    type:
      - 'null'
      - float
    doc: Weight for paths during consensus generation.
    inputBinding:
      position: 101
      prefix: --path-weight
  - id: poa_params
    type:
      - 'null'
      - string
    doc: Score parameters for POA in the form of 
      match,mismatch,gap_open,gap_extend.
    inputBinding:
      position: 101
      prefix: --poa-params
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size for the smoothing window.
    inputBinding:
      position: 101
      prefix: --step-size
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of the window to use for smoothing.
    inputBinding:
      position: 101
      prefix: --window-size
  - id: write_maf
    type:
      - 'null'
      - boolean
    doc: Write a MAF representation of the alignment.
    inputBinding:
      position: 101
      prefix: --write-maf
outputs:
  - id: gfa_out
    type:
      - 'null'
      - File
    doc: Output GFA file.
    outputBinding:
      glob: $(inputs.gfa_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smoothxg:0.8.2--h2fa790d_1
