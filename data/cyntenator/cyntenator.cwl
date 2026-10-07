cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyntenator
label: cyntenator
doc: "guide-tree: -t \"((rat.txt mouse.txt ) human.txt)\"\nHomology: -h id -h blast
  [file] -h orthologs [file] -h phylo [file] [weighted_tree]\nAlignment Parameters:\n\
  \t-thr\tthreshold (4)\n\t-gap\tgap (-2)\n\t-mis\tmismatch (-3)\n\nFilter options:\n\
  \t-filter [int] best alignments or only unique assignments n=0 (100)\n\t-coverage
  [int] each gene may occur only c times in alignments (2)\n\t-length [int] minimum
  alignment length treshold (1)\n\t-last prints only the alignments at the last step\n\
  \nOutput:\n\t-o output file\n\nTool homepage: https://github.com/dieterich-lab/cyntenator"
inputs:
  - id: genome_files
    type:
      type: array
      items: File
    doc: Gene annotation files (genome, sequence or alignment format) named in 
      the guide tree; staged in the working directory so the names resolve
  - id: homology_type
    type: string
    doc: Homology type (id, blast, orthologs or phylo)
    inputBinding:
      position: 2
      prefix: -h
  - id: homology_file
    type:
      - 'null'
      - File
    doc: Optional file for homology type
    inputBinding:
      position: 3
  - id: weighted_tree
    type:
      - 'null'
      - string
    doc: Weighted species tree for phylo homology type, e.g. 
      "((HSX.txt:1.2 MMX.txt:1.3):0.5 CFX.txt:2.5):1"
    inputBinding:
      position: 4
  - id: coverage
    type:
      - 'null'
      - int
    doc: each gene may occur only c times in alignments
    inputBinding:
      position: 104
      prefix: -coverage
  - id: filter_best_alignments
    type:
      - 'null'
      - int
    doc: best alignments or only unique assignments n=0
    inputBinding:
      position: 104
      prefix: -filter
  - id: gap
    type:
      - 'null'
      - float
    doc: gap
    inputBinding:
      position: 104
      prefix: -gap
  - id: guide_tree
    type: string
    doc: 'guide-tree: -t "((rat.txt mouse.txt ) human.txt)"'
    inputBinding:
      position: 1
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
    inputBinding:
      position: 104
      prefix: -length
  - id: mismatch
    type:
      - 'null'
      - float
    doc: mismatch
    inputBinding:
      position: 104
      prefix: -mis
  - id: threshold
    type:
      - 'null'
      - float
    doc: threshold
    inputBinding:
      position: 104
      prefix: -thr
  - id: output_file_path
    type: string
    doc: output file
    inputBinding:
      position: 105
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.genome_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyntenator:0.0.r2326--h9948957_4
