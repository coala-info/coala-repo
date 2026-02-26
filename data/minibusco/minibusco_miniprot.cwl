cwlVersion: v1.2
class: CommandLineTool
baseCommand: minibusco miniprot
label: minibusco_miniprot
doc: "Miniprot alignment\n\nTool homepage: https://github.com/huangnengCSU/minibusco"
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
  - id: outdir
    type: Directory
    doc: Miniprot alignment output directory
    inputBinding:
      position: 101
      prefix: --outdir
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minibusco:0.2.1--pyh7cba7a3_0
stdout: minibusco_miniprot.out
