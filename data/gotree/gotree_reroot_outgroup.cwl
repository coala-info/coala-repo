cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - reroot
  - outgroup
label: gotree_reroot_outgroup
doc: "Reroot the tree using an outgroup given in argument or in stdin.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: remove_outgroup
    type:
      - 'null'
      - boolean
    doc: "Removes the outgroup after reroot"
    inputBinding:
      position: 101
      prefix: --remove-outgroup
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
    doc: "Input Tree"
    inputBinding:
      position: 101
      prefix: --input
  - id: output_file_path
    type: string
    doc: "Rerooted output tree file"
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
  - id: output_file
    type: File
    doc: "Output file written to the path in output_file_path"
    outputBinding:
      glob: "$(inputs.output_file_path)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
