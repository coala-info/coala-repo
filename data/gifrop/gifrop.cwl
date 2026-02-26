cwlVersion: v1.2
class: CommandLineTool
baseCommand: gifrop
label: gifrop
doc: "This script should be executed from a directory that contains a roary generated
  'gene_presence_absence.csv' file and all of the prokka annotated gff files that
  were used to run roary.\n\nTool homepage: https://github.com/jtrachsel/gifrop"
inputs:
  - id: flank_dna
    type:
      - 'null'
      - int
    doc: output this many bases of DNA on either side of each island
    default: 0
    inputBinding:
      position: 101
      prefix: --flank_dna
  - id: get_islands
    type:
      - 'null'
      - boolean
    doc: Run the main program to extract genomic islands
    inputBinding:
      position: 101
      prefix: --get_islands
  - id: min_genes
    type:
      - 'null'
      - int
    doc: Only return islands with greater than this many genes
    default: 4
    inputBinding:
      position: 101
      prefix: --min_genes
  - id: no_plots
    type:
      - 'null'
      - boolean
    doc: Don't generate plots
    inputBinding:
      position: 101
      prefix: --no_plots
  - id: qcut
    type:
      - 'null'
      - float
    doc: prune edges with jaccard sim less than qcut before quat cluster
    default: 0.75
    inputBinding:
      position: 101
      prefix: --qcut
  - id: reference
    type:
      - 'null'
      - string
    doc: Find genomic islands relative to this reference
    inputBinding:
      position: 101
      prefix: --reference
  - id: scut
    type:
      - 'null'
      - float
    doc: prune edges with OC less than scut before secondary cluster
    default: 0.5
    inputBinding:
      position: 101
      prefix: --scut
  - id: split_islands
    type:
      - 'null'
      - boolean
    doc: Write one fasta file for each genomic island
    inputBinding:
      position: 101
      prefix: --split_islands
  - id: tcut
    type:
      - 'null'
      - float
    doc: prune edges with OC less than tcut before tertiary cluster
    default: 0.75
    inputBinding:
      position: 101
      prefix: --tcut
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel abricate commands
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gifrop:0.0.9--hdfd78af_0
stdout: gifrop.out
