cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - compute
  - roccurve
label: gotree_compute_roccurve
doc: "Computes true positives and false positives at different thresholds.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: input_tree
    type: File
    doc: "Input tree file"
    inputBinding:
      position: 101
      prefix: --intree
  - id: length_geq
    type:
      - 'null'
      - float
    doc: "Keep only branches that are >= value (-1=No filter)"
    inputBinding:
      position: 101
      prefix: --length-geq
  - id: length_leq
    type:
      - 'null'
      - float
    doc: "Keep only branches that are <= value (-1=No filter)"
    inputBinding:
      position: 101
      prefix: --length-leq
  - id: max
    type:
      - 'null'
      - float
    doc: "Max threshold"
    inputBinding:
      position: 101
      prefix: --max
  - id: min
    type:
      - 'null'
      - float
    doc: "Min threshold"
    inputBinding:
      position: 101
      prefix: --min
  - id: out_file_path
    type:
      - 'null'
      - string
    doc: "Output tree file, with supports"
    inputBinding:
      position: 101
      prefix: --out
  - id: pvalue
    type:
      - 'null'
      - float
    doc: "Keep only branches that have a pvalue <=  value"
    inputBinding:
      position: 101
      prefix: --pvalue
  - id: step
    type:
      - 'null'
      - float
    doc: "Step between each threshold"
    inputBinding:
      position: 101
      prefix: --step
  - id: true_tree
    type: File
    doc: "True tree file"
    inputBinding:
      position: 101
      prefix: --truetree
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
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
  - id: out_file
    type:
      - 'null'
      - File
    doc: "Output tree file, with supports"
    outputBinding:
      glob: "$(inputs.out_file_path)"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_compute_roccurve.out
