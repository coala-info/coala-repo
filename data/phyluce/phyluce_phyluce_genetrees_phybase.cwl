cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_phybase
label: phyluce_phyluce_genetrees_phybase
doc: "Phybase.py calculates species trees from gene trees.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: File
    doc: "The path to the input genetrees or bootreps. Must be parsed using reformat_raxml_output.py."
    inputBinding:
      position: 1
      prefix: --input
  - id: outgroup
    type:
      - 'null'
      - string
    doc: "The name of the outgroup on which the trees are rooted. Not needed for NJst"
    inputBinding:
      position: 2
      prefix: --outgroup
  - id: method
    type:
      - 'null'
      - string
    doc: "The method to use. One of star, njst."
    inputBinding:
      position: 3
      prefix: --method
  - id: cores
    type:
      - 'null'
      - int
    doc: "The number of compute cores to use"
    inputBinding:
      position: 4
      prefix: --cores
  - id: genetrees
    type:
      - 'null'
      - boolean
    doc: "Choose this if you want to generate the species tree from gene trees."
    inputBinding:
      position: 5
      prefix: --genetrees
  - id: bootreps
    type:
      - 'null'
      - boolean
    doc: "Choose this if you want to generate support values for bootrepped gene trees"
    inputBinding:
      position: 6
      prefix: --bootreps
outputs:
  - id: stdout_log
    type: File
    doc: "Standard output of the program."
    outputBinding:
      glob: "phybase.stdout.txt"
  - id: species_trees
    type:
      - 'null'
      - type: array
        items: File
    doc: "Species tree files written next to the input file (*.species.tre)."
    outputBinding:
      glob: "*.species.tre"
  - id: bootrep_trees
    type:
      - 'null'
      - type: array
        items: File
    doc: "Bootstrap species tree and consensus files written next to the input file (*.bootrep.*)."
    outputBinding:
      glob: "*.bootrep.*"
stdout: phybase.stdout.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
