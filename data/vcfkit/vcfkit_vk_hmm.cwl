cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - hmm
label: vcfkit_vk_hmm
doc: "Hidden Markov model for imputing genotypes from parental genotypes in linkage studies.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: parent_a
    type: string
    doc: "Sample name of parent 1"
    inputBinding:
      position: 1
      prefix: --A=
      separate: false
  - id: parent_b
    type: string
    doc: "Sample name of parent 2"
    inputBinding:
      position: 1
      prefix: --B=
      separate: false
  - id: vcf_out
    type:
      - 'null'
      - boolean
    doc: "Output VCF instead of intervals"
    inputBinding:
      position: 1
      prefix: --vcf-out
  - id: endfill
    type:
      - 'null'
      - boolean
    doc: "Do not leave gaps at the ends of chromosomes"
    inputBinding:
      position: 1
      prefix: --endfill
  - id: infill
    type:
      - 'null'
      - boolean
    doc: "Fill in missing portions"
    inputBinding:
      position: 1
      prefix: --infill
  - id: state
    type:
      - 'null'
      - float
    doc: "State probability (default 0.97)"
    inputBinding:
      position: 1
      prefix: --state=
      separate: false
  - id: transition
    type:
      - 'null'
      - float
    doc: "Transition probability (default 1e-9)"
    inputBinding:
      position: 1
      prefix: --transition=
      separate: false
  - id: vcf
    type: File
    doc: "Input VCF or BCF file"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk_hmm.out
