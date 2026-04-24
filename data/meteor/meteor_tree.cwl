cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Meteor
  - tree
label: meteor_tree
doc: "Infer phylogenetic trees from strain directories using various models and output
  formats.\n\nTool homepage: https://github.com/metagenopolis/meteor"
inputs:
  - id: height
    type:
      - 'null'
      - int
    doc: 'Output image height (default: 500px).'
    inputBinding:
      position: 101
      prefix: -H
  - id: max_gap
    type:
      - 'null'
      - float
    doc: 'Removes sites constitued of >= cutoff gap character (default: >= 1.0).'
    inputBinding:
      position: 101
      prefix: -g
  - id: min_info_sites
    type:
      - 'null'
      - int
    doc: 'Minimum number of informative sites in the alignment (default: >= 10).'
    inputBinding:
      position: 101
      prefix: -s
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output image format (default: None).'
    inputBinding:
      position: 101
      prefix: -f
  - id: strain_dir
    type: Directory
    doc: Path to the strain directory.
    inputBinding:
      position: 101
      prefix: -i
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads when infering each tree (default: 1).'
    inputBinding:
      position: 101
      prefix: -t
  - id: tmp_path
    type:
      - 'null'
      - Directory
    doc: Path to the directory where temporary files are stored
    inputBinding:
      position: 101
      prefix: --tmp
  - id: tn93_model
    type:
      - 'null'
      - boolean
    doc: 'Compute tn93 model (faster) (default: GTR).'
    inputBinding:
      position: 101
      prefix: -r
  - id: width
    type:
      - 'null'
      - int
    doc: 'Output image width (default: 500px).'
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: tree_dir
    type: Directory
    doc: Path to output directory.
    outputBinding:
      glob: $(inputs.tree_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
