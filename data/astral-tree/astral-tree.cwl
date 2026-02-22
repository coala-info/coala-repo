cwlVersion: v1.2
class: CommandLineTool
baseCommand: astral
label: astral-tree
doc: "ASTRAL is a tool for estimating an unrooted species tree given a set of unrooted
  gene trees. (Note: The provided text appears to be a container engine error log
  rather than help text; arguments below are based on standard ASTRAL CLI usage).\n\
  \nTool homepage: https://github.com/smirarab/ASTRAL"
inputs:
  - id: annotation_level
    type:
      - 'null'
      - int
    doc: 'Annotation level: 0 (none), 1 (quartet support), 2 (full annotation).'
    default: 0
    inputBinding:
      position: 101
      prefix: -t
  - id: cpu_cores
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: -T
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
  - id: quartet_file
    type:
      - 'null'
      - File
    doc: A file containing quartets to be used for the search.
    inputBinding:
      position: 101
      prefix: --quartets
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The file to write the output species tree to.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/astral-tree:5.7.8--hdfd78af_1
