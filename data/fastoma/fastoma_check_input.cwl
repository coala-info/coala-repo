cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastoma-check-input
label: fastoma_check_input
doc: "Check the input parameters for FastOMA (proteomes, species tree, optional splice, hogmap and OMAmer database) and write a sanitised species tree.\n\nTool homepage: https://github.com/DessimozLab/FastOMA"
inputs:
  - id: proteomes
    type: Directory
    doc: Path to the folder containing the input proteomes
    inputBinding:
      position: 1
      prefix: --proteomes
  - id: species_tree
    type: File
    doc: Path to the input species tree file in newick format
    inputBinding:
      position: 2
      prefix: --species-tree
  - id: out_tree
    type: string
    doc: Path to output file for sanitised species tree.
    inputBinding:
      position: 3
      prefix: --out-tree
  - id: splice
    type:
      - 'null'
      - Directory
    doc: Path to the folder containing the splice information files
    inputBinding:
      position: 4
      prefix: --splice
  - id: hogmap
    type:
      - 'null'
      - Directory
    doc: Path to the folder containing the hogmap files
    inputBinding:
      position: 5
      prefix: --hogmap
  - id: omamer_db
    type:
      - 'null'
      - File
    doc: Path to the omamer database
    inputBinding:
      position: 6
      prefix: --omamer_db
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity to info/debug
    inputBinding:
      position: 7
      prefix: -v
outputs:
  - id: sanitised_species_tree
    type:
      - 'null'
      - File
    doc: Sanitised species tree.
    outputBinding:
      glob: $(inputs.out_tree)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastoma:0.5.1--pyhdfd78af_0
stdout: fastoma_check_input.out
