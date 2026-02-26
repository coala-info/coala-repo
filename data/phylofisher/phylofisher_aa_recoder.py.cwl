cwlVersion: v1.2
class: CommandLineTool
baseCommand: aa_recoder.py
label: phylofisher_aa_recoder.py
doc: "Recodes input matrix based on SR4 amino acid classification.\n\nTool homepage:
  https://github.com/TheBrownLab/PhyloFisher"
inputs:
  - id: in_format
    type:
      - 'null'
      - string
    doc: 'Input file format if not FASTA. Options: fasta, phylip (names truncated
      at 10 characters), phylip-relaxed (names are not truncated), or nexus.'
    default: fasta
    inputBinding:
      position: 101
      prefix: --in_format
  - id: input_matrix
    type: File
    doc: Path to input matrix for recoding.
    inputBinding:
      position: 101
      prefix: --input
  - id: out_format
    type:
      - 'null'
      - string
    doc: 'Desired output format. Options: fasta, phylip (names truncated at 10 characters),
      phylip-relaxed (names are not truncated), or nexus.'
    default: fasta
    inputBinding:
      position: 101
      prefix: --out_format
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to user-defined output directory
    default: ./aa_recoder_out_<M.D.Y>
    inputBinding:
      position: 101
      prefix: --output
  - id: recoding_strategy
    type: string
    doc: 'Desired recoding strategy. Options: SR4, SR6, KGB6, D6, D9, D12, D15, or
      D18.'
    inputBinding:
      position: 101
      prefix: --recoding_strat
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
stdout: phylofisher_aa_recoder.py.out
