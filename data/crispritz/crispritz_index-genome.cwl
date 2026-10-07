cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crispritz.py
  - index-genome
label: crispritz_index-genome
doc: "Create a genome index (ternary search tree) to perform fast searches with bulges.\n  \nTool homepage: https://github.com/InfOmics/CRISPRitz"
inputs:
  - id: name_genome
    type: string
    doc: Name of the genome to create
    inputBinding:
      position: 1
  - id: genome_dir
    type: Directory
    doc: Directory containing a genome in .fa or .fasta format, need to be 
      separated into single chromosome files.
    inputBinding:
      position: 2
  - id: pam_file
    type: File
    doc: Text file containing the PAM (including a number of Ns equal to the 
      guide length) and a space separated number indicating the length of the 
      PAM sequence
    inputBinding:
      position: 3
  - id: max_bulges
    type: int
    doc: Number of bulges allowed for the search phase
    inputBinding:
      position: 4
      prefix: -bMax
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Default uses 4 threads
    inputBinding:
      position: 4
      prefix: -th
outputs:
  - id: genome_index
    type: Directory
    doc: Genome index folder genome_library/<PAM>_<bMax>_<name_genome> with one
      .bin file per chromosome
    outputBinding:
      glob: genome_library/*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
