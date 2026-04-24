cwlVersion: v1.2
class: CommandLineTool
baseCommand: compute_fununifrac.py
label: fununifrac_compute_fununifrac.py
doc: "This script will take a directory of sourmash gather results and a weighted
  edge list representing the KEGG hierarchy and compute all pairwise functional unifrac
  distances.\n\nTool homepage: https://github.com/KoslickiLab/FunUniFrac"
inputs:
  - id: abundance_key
    type:
      - 'null'
      - string
    doc: "Key in the gather results to use for abundance.\n                      \
      \  Default is `f_unique_weighted`"
    inputBinding:
      position: 101
      prefix: --abundance_key
  - id: brite
    type:
      - 'null'
      - string
    doc: "Use the subtree of the KEGG hierarchy rooted at the\n                  \
      \      given BRITE ID. eg. brite:ko00001"
    inputBinding:
      position: 101
      prefix: --brite
  - id: diffab
    type:
      - 'null'
      - boolean
    doc: Also return the difference abundance vectors.
    inputBinding:
      position: 101
      prefix: --diffab
  - id: edge_list
    type: File
    doc: "Input edge list file of the KEGG hierarchy. Must have\n                \
      \        lengths in the third column."
    inputBinding:
      position: 101
      prefix: --edge_list
  - id: file_dir
    type: Directory
    doc: Directory of sourmash files.
    inputBinding:
      position: 101
      prefix: --file_dir
  - id: file_pattern
    type:
      - 'null'
      - string
    doc: "Pattern to match files in the directory. Default is\n                  \
      \      '*_gather.csv'"
    inputBinding:
      position: 101
      prefix: --file_pattern
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the output file if it exists
    inputBinding:
      position: 101
      prefix: --force
  - id: l2
    type:
      - 'null'
      - boolean
    doc: Use L2 UniFrac instead of L1
    inputBinding:
      position: 101
      prefix: --L2
  - id: out_id
    type:
      - 'null'
      - string
    doc: "Test purpose: give an identifier to the output file so\n               \
      \         that tester can recognize it"
    inputBinding:
      position: 101
      prefix: --out_id
  - id: ppushed
    type:
      - 'null'
      - boolean
    doc: "Flag indicating you want the pushed vectors to be\n                    \
      \    saved."
    inputBinding:
      position: 101
      prefix: --Ppushed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use. Default is half the cores\n                  \
      \      available."
    inputBinding:
      position: 101
      prefix: --threads
  - id: unweighted
    type:
      - 'null'
      - boolean
    doc: "Compute unweighted unifrac instead of the default\n                    \
      \    weighted version"
    inputBinding:
      position: 101
      prefix: --unweighted
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory name.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fununifrac:0.0.1--pyh7cba7a3_0
