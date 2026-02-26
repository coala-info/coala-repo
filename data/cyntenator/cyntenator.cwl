cwlVersion: v1.2
class: CommandLineTool
baseCommand: program
label: cyntenator
doc: "guide-tree: -t \"((rat.txt mouse.txt ) human.txt)\"\nHomology: -h id -h blast
  [file] -h orthologs [file] -h phylo [file] [weighted_tree]\nAlignment Parameters:\n\
  \t-thr\tthreshold (4)\n\t-gap\tgap (-2)\n\t-mis\tmismatch (-3)\n\nFilter options:\n\
  \t-filter [int] best alignments or only unique assignments n=0 (100)\n\t-coverage
  [int] each gene may occur only c times in alignments (2)\n\t-length [int] minimum
  alignment length treshold (1)\n\t-last prints only the alignments at the last step\n\
  \nOutput:\n\t-o output file\n\nTool homepage: https://github.com/dieterich-lab/cyntenator"
inputs:
  - id: homology_type
    type: string
    doc: Homology type
    inputBinding:
      position: 1
  - id: homology_file
    type:
      - 'null'
      - File
    doc: Optional file for homology type
    inputBinding:
      position: 2
  - id: weighted_tree
    type:
      - 'null'
      - File
    doc: Optional weighted tree for phylo homology type
    inputBinding:
      position: 3
  - id: coverage
    type:
      - 'null'
      - int
    doc: each gene may occur only c times in alignments
    default: 2
    inputBinding:
      position: 104
      prefix: -coverage
  - id: filter_best_alignments
    type:
      - 'null'
      - int
    doc: best alignments or only unique assignments n=0
    default: 100
    inputBinding:
      position: 104
      prefix: -filter
  - id: gap
    type:
      - 'null'
      - int
    doc: gap
    default: -2
    inputBinding:
      position: 104
      prefix: -gap
  - id: guide_tree
    type:
      - 'null'
      - string
    doc: 'guide-tree: -t "((rat.txt mouse.txt ) human.txt)"'
    inputBinding:
      position: 104
      prefix: -t
  - id: last_step_alignments
    type:
      - 'null'
      - boolean
    doc: prints only the alignments at the last step
    inputBinding:
      position: 104
      prefix: -last
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: minimum alignment length treshold
    default: 1
    inputBinding:
      position: 104
      prefix: -length
  - id: mismatch
    type:
      - 'null'
      - int
    doc: mismatch
    default: -3
    inputBinding:
      position: 104
      prefix: -mis
  - id: threshold
    type:
      - 'null'
      - float
    doc: threshold
    default: 4
    inputBinding:
      position: 104
      prefix: -thr
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyntenator:0.0.r2326--h9948957_4
