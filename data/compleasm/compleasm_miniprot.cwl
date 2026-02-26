cwlVersion: v1.2
class: CommandLineTool
baseCommand: compleasm miniprot
label: compleasm_miniprot
doc: "Miniprot alignment\n\nTool homepage: https://github.com/huangnengCSU/compleasm"
inputs:
  - id: assembly
    type: File
    doc: Input genome file in FASTA format
    inputBinding:
      position: 101
      prefix: --assembly
  - id: miniprot_execute_path
    type:
      - 'null'
      - string
    doc: Path to miniprot executable
    inputBinding:
      position: 101
      prefix: --miniprot_execute_path
  - id: outs
    type:
      - 'null'
      - float
    doc: output if score at least FLOAT*bestScore
    default: 0.95
    inputBinding:
      position: 101
      prefix: --outs
  - id: protein
    type: File
    doc: Input protein file
    inputBinding:
      position: 101
      prefix: --protein
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type: Directory
    doc: Miniprot alignment output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/compleasm:0.2.7--pyh7e72e81_1
