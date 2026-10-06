cwlVersion: v1.2
class: CommandLineTool
baseCommand: astral
label: astral-tree
doc: "ASTRAL is a tool for estimating an unrooted species tree given a set of unrooted
  gene trees.\n\nTool homepage: https://github.com/smirarab/ASTRAL"
inputs:
  - id: annotation_level
    type:
      - 'null'
      - int
    doc: 'Annotation level: 0 (none), 1 (quartet support), 2 (full annotation).'
    inputBinding:
      position: 101
      prefix: -t
  - id: exact
    type:
      - 'null'
      - boolean
    doc: Run the exact version of ASTRAL (only for small datasets).
    inputBinding:
      position: 101
      prefix: --exact
  - id: input_file
    type: File
    doc: The file containing the input gene trees in Newick format.
    inputBinding:
      position: 101
      prefix: --input
  - id: score_tree
    type:
      - 'null'
      - File
    doc: Score the provided species tree and exit.
    inputBinding:
      position: 101
      prefix: --score-tree
  - id: name_map_file
    type:
      - 'null'
      - File
    doc: File mapping gene tree names to species names.
    inputBinding:
      position: 101
      prefix: --namemapfile
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: The file to write the output species tree to.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/astral-tree:5.7.8--hdfd78af_1
