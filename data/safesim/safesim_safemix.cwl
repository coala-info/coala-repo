cwlVersion: v1.2
class: CommandLineTool
baseCommand: safemix
label: safesim_safemix
doc: "This program mixes two bam files and is aware of the molecular-barcodes (also
  known as unique molecular identifiers (UMIs))\n\nTool homepage: https://github.com/genetronhealth/safesim"
inputs:
  - id: normal_initial_quantity
    type:
      - 'null'
      - float
    doc: initial quantity of DNA in ng sequenced in the <NORMAL-INPUT-BAM> file
    inputBinding:
      position: 101
      prefix: -j
  - id: normal_input_bam
    type: File
    doc: normal-INPUT-BAM file
    inputBinding:
      position: 101
      prefix: -b
  - id: normal_umi_size
    type:
      - 'null'
      - float
    doc: average number of reads in a UMI family in the <NORMAL-INPUT-BAM> file
    inputBinding:
      position: 101
      prefix: -e
  - id: output_prefix
    type: string
    doc: OUTPUT-PREFIX is appended by the string literals ".tumor.bam" and 
      ".normal.bam" (without the double quotes) to generate the tumor and normal
      simulated BAM filenames, respectively.
    inputBinding:
      position: 101
      prefix: -o
  - id: random_seed_for_initial_quantity
    type:
      - 'null'
      - int
    doc: random seed used to select the UMI from the initial quantity of DNA
    inputBinding:
      position: 101
      prefix: -r
  - id: random_seed_for_umi_size
    type:
      - 'null'
      - int
    doc: random seed used to select the reads in each UMI
    inputBinding:
      position: 101
      prefix: -s
  - id: tumor_fraction
    type:
      - 'null'
      - float
    doc: the fraction of DNA that comes from tumor
    inputBinding:
      position: 101
      prefix: -f
  - id: tumor_initial_quantity
    type:
      - 'null'
      - float
    doc: initial quantity of DNA in ng sequenced in the <TUMOR-INPUT-BAM> file
    inputBinding:
      position: 101
      prefix: -i
  - id: tumor_input_bam
    type: File
    doc: tumor-INPUT-BAM file
    inputBinding:
      position: 101
      prefix: -a
  - id: tumor_umi_size
    type:
      - 'null'
      - float
    doc: average number of reads in a UMI family in the <TUMOR-INPUT-BAM> file
    inputBinding:
      position: 101
      prefix: -d
  - id: use_only_umi
    type:
      - 'null'
      - boolean
    doc: set the program to use only UMIs for identifying read families (discard
      read start and end positions)
    inputBinding:
      position: 101
      prefix: -U
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/safesim:0.1.6.8d44580--h7d57edc_4
stdout: safesim_safemix.out
