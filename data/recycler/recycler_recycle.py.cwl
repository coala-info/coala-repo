cwlVersion: v1.2
class: CommandLineTool
baseCommand: recycle.py
label: recycler_recycle.py
doc: "Recycler extracts likely plasmids (and other circular DNA elements) from de
  novo assembly graphs\n\nTool homepage: https://github.com/Shamir-Lab/Recycler"
inputs:
  - id: bam
    type: File
    doc: BAM file resulting from aligning reads to contigs file, filtering for 
      best matches
    inputBinding:
      position: 101
      prefix: --bam
  - id: graph
    type: File
    doc: '(spades 3.50+) assembly graph FASTG file to process; recommended for spades
      3.5: before_rr.fastg, for spades 3.6+:assembly_graph.fastg'
    inputBinding:
      position: 101
      prefix: --graph
  - id: iso
    type:
      - 'null'
      - boolean
    doc: True or False value reflecting whether data sequenced was an isolated 
      strain
    inputBinding:
      position: 101
      prefix: --iso
  - id: length
    type:
      - 'null'
      - int
    doc: minimum length required for reporting
    inputBinding:
      position: 101
      prefix: --length
  - id: max_cv
    type:
      - 'null'
      - float
    doc: coefficient of variation used for pre-selection, higher--> less 
      restrictive
    inputBinding:
      position: 101
      prefix: --max_CV
  - id: max_k
    type: int
    doc: integer reflecting maximum k value used by the assembler
    inputBinding:
      position: 101
      prefix: --max_k
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
