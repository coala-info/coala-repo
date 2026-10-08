cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - collapse
  - clade
label: gotree_collapse_clade
doc: "Collapse the clade defined by the given tip names, and replace it by a tip with a given name.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: clade_output_path
    type:
      - 'null'
      - string
    doc: "Output tree file with the collapsed clade"
    inputBinding:
      position: 101
      prefix: --clade-output
  - id: strict
    type:
      - 'null'
      - boolean
    doc: "Enforce the outgroup to be monophyletic (else throw an error)"
    inputBinding:
      position: 101
      prefix: --strict
  - id: tip_file
    type:
      - 'null'
      - File
    doc: "File containing names of tips of the outgroup"
    inputBinding:
      position: 101
      prefix: --tip-file
  - id: tip_name
    type: string
    doc: "Name of the tip that will replace the clade"
    inputBinding:
      position: 101
      prefix: --tip-name
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: input_tree
    type: File
    doc: "Input tree"
    inputBinding:
      position: 101
      prefix: --input
  - id: output_file_path
    type: string
    doc: "Collapsed tree output file"
    inputBinding:
      position: 101
      prefix: --output
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
  - id: tip_names
    type:
      - 'null'
      - type: array
        items: string
    doc: "Tip names given as arguments (alternative to the tip file)"
    inputBinding:
      position: 200
outputs:
  - id: clade_output_file
    type:
      - 'null'
      - File
    doc: "Output tree file with the collapsed clade"
    outputBinding:
      glob: "$(inputs.clade_output_path)"
  - id: output_file
    type: File
    doc: "Output file written to the path in output_file_path"
    outputBinding:
      glob: "$(inputs.output_file_path)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
