cwlVersion: v1.2
class: CommandLineTool
baseCommand: tcfinder
label: tcfinder
doc: "finds clusters of samples from a list of identifiers within a phylo4 phylogeny
  (see https://cran.r-project.org/web/packages/phylobase/vignettes/phylobase.html)\n\
  \nTool homepage: https://github.com/PathoGenOmics-Lab/tcfinder"
inputs:
  - id: minimum_prop
    type:
      - 'null'
      - float
    doc: Minimum proportion of targets in cluster
    inputBinding:
      position: 101
      prefix: --minimum-prop
  - id: minimum_size
    type:
      - 'null'
      - int
    doc: Minimum number of tips (cluster size)
    inputBinding:
      position: 101
      prefix: --minimum-size
  - id: targets
    type: File
    inputBinding:
      position: 101
      prefix: --targets
  - id: tree
    type: File
    inputBinding:
      position: 101
      prefix: --tree
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints debug messages
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output CSV file with clustering result
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tcfinder:1.0.0--h4349ce8_0
