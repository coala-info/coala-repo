cwlVersion: v1.2
class: CommandLineTool
baseCommand: getargs_genome_maker.py
label: repenrich_RepEnrich_setup.py
doc: "Part I: Prepartion of repetive element psuedogenomes and repetive element\n\
  bamfiles. This script prepares the annotation used by downstream applications\n\
  to analyze for repetitive element enrichment. For this script to run properly\n\
  bowtie must be loaded. The repeat element psuedogenomes are prepared in order\n\
  to analyze reads that map to multiple locations of the genome. The repeat\nelement
  bamfiles are prepared in order to use a region sorter to analyze reads\nthat map
  to a single location of the genome.You will 1) annotation_file: The\nrepetitive
  element annotation file downloaded from RepeatMasker.org database\nfor your organism
  of interest. 2) genomefasta: Your genome of interest in\nfasta format, 3)setup_folder:
  a folder to contain repeat element setup files\ncommand-line usage EXAMPLE: python
  master_setup.py\n/users/nneretti/data/annotation/mm9/mm9_repeatmasker.txt\n/users/nneretti/data/annotation/mm9/mm9.fa\n\
  /users/nneretti/data/annotation/mm9/setup_folder\n\nTool homepage: https://github.com/nskvir/RepEnrich"
inputs:
  - id: annotation_file
    type: File
    doc: "List annotation file. The annotation file contains the\n               \
      \         repeat masker annotation for the genome of interest\n            \
      \            and may be downloaded at RepeatMasker.org Example\n           \
      \             /data/annotation/mm9/mm9.fa.out"
    inputBinding:
      position: 1
  - id: genomefasta
    type: File
    doc: "File name and path for genome of interest in fasta\n                   \
      \     format. Example /data/annotation/mm9/mm9.fa"
    inputBinding:
      position: 2
  - id: setup_folder
    type: Directory
    doc: "List folder to contain bamfiles for repeats and repeat\n               \
      \         element psuedogenomes. Example\n                        /data/annotation/mm9/setup"
    inputBinding:
      position: 3
  - id: flankinglength
    type:
      - 'null'
      - int
    doc: "Length of the flanking region adjacent to the repeat\n                 \
      \       element that is used to build repeat psuedogeneomes.\n             \
      \           The flanking length should be set according to the\n           \
      \             length of your reads."
    inputBinding:
      position: 104
      prefix: --flankinglength
  - id: gaplength
    type:
      - 'null'
      - int
    doc: "Length of the spacer used to build repeat\n                        psuedogeneomes."
    inputBinding:
      position: 104
      prefix: --gaplength
  - id: is_bed
    type:
      - 'null'
      - boolean
    doc: "Is the annotation file a bed file. This is also a\n                    \
      \    compatible format. The file needs to be a tab\n                       \
      \ seperated bed with optional fields. Ex. format chr\n                     \
      \   start end Name_element class family. The class and\n                   \
      \     family should identical to name_element if not\n                     \
      \   applicable."
    inputBinding:
      position: 104
      prefix: --is_bed
outputs:
  - id: nfragmentsfile1
    type:
      - 'null'
      - File
    doc: "Output location of a description file that saves the\n                 \
      \       number of fragments processed per repname."
    outputBinding:
      glob: $(inputs.nfragmentsfile1)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repenrich:1.2--py27_1
