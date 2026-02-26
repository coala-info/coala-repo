cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapidnj
label: rapidnj
doc: "RapidNJ is an efficient implementation of the neighbor-joining method for phylogenetic
  tree reconstruction.\n\nTool homepage: http://birc.au.dk/software/rapidnj/"
inputs:
  - id: input_file
    type: File
    doc: Input alignment or distance matrix file
    inputBinding:
      position: 1
  - id: bootstraps
    type:
      - 'null'
      - int
    doc: Number of bootstrap replicates
    inputBinding:
      position: 102
      prefix: -b
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use
    inputBinding:
      position: 102
      prefix: -c
  - id: evolutionary_model
    type:
      - 'null'
      - string
    doc: 'Evolutionary model to use: jc (Jukes-Cantor) or kimura (Kimura 2-parameter)'
    inputBinding:
      position: 102
      prefix: -m
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Input format: pd (distance matrix), fa (fasta), st (stockholm), or ma (phylip/multi-aligned)'
    inputBinding:
      position: 102
      prefix: -i
  - id: no_sorting
    type:
      - 'null'
      - boolean
    doc: Disable the use of sorted lists (may be faster for very small datasets)
    inputBinding:
      position: 102
      prefix: -n
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format: t (newick tree) or m (distance matrix)'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapidnj:v2.3.2--h2d50403_0
