cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - generate
  - balancedtree
label: gotree_generate_balancedtree
doc: "Generates a random balanced binary tree.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: depth
    type:
      - 'null'
      - int
    doc: "Depth of the balanced binary tree"
    inputBinding:
      position: 101
      prefix: --depth
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: nbtrees
    type:
      - 'null'
      - int
    doc: "Number of trees to generate"
    inputBinding:
      position: 101
      prefix: --nbtrees
  - id: output_file_path
    type: string
    doc: "Tree output file"
    inputBinding:
      position: 101
      prefix: --output
  - id: rooted
    type:
      - 'null'
      - boolean
    doc: "Generate rooted trees"
    inputBinding:
      position: 101
      prefix: --rooted
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random Seed: -1 = nano seconds since 1970/01/01 00:00:00"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Max=20)"
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: "Output file written to the path in output_file_path"
    outputBinding:
      glob: "$(inputs.output_file_path)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
