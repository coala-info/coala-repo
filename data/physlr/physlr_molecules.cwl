cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, molecules]
label: physlr_molecules
doc: "Separate barcodes into molecules: partition the neighbourhood of each barcode and write a graph whose vertices are molecules (barcode_N).\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: min_shared_minimizers
    type: ['null', int]
    doc: "remove edges with fewer than this many shared minimizers [0]"
    inputBinding:
      position: 1
      prefix: -m
  - id: separation_strategy
    type: ['null', string]
    doc: "strategy for barcode to molecule separation [bc+k3]. Use a combination of bc, cc, cn2, cn3, k3, k3bin, k4, cos, sqcos, sqcosbin, louvain and distributed joined by plus signs (example bc+k3+bc)"
    inputBinding:
      position: 2
      prefix: --separation-strategy
  - id: separation_skip_small
    type: ['null', int]
    doc: "skip splitting the barcode if its neighbourhood subgraph is smaller than this [10]"
    inputBinding:
      position: 3
      prefix: --separation-skip-small
  - id: sqcost
    type: ['null', float]
    doc: "threshold for sqcos molecule separation [0.75]"
    inputBinding:
      position: 4
      prefix: --sqcost
  - id: threads
    type: ['null', int]
    doc: "number of threads [16 or number of CPU]"
    inputBinding:
      position: 5
      prefix: -t
  - id: output_format
    type: ['null', string]
    doc: "the output graph file format [tsv]. Only tsv works in this image (gv needs pygraphviz, which is missing)"
    inputBinding:
      position: 6
      prefix: -O
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 7
      prefix: -V
  - id: graph_file
    type: File
    doc: "Graph file in TSV format (header U, m and optional mol; then a blank line and the U, V, m edge table)"
    inputBinding:
      position: 100
  - id: junctions_file
    type: ['null', File]
    doc: "optional TSV file listing the junction-causing barcodes in the first column; when given, only these barcodes are separated with the chosen strategy and all other barcodes with bc"
    inputBinding:
      position: 101
outputs:
  - id: result
    type: File
    doc: "Molecule graph in TSV format (vertices are barcode_N)"
    outputBinding:
      glob: physlr_molecules.tsv
stdout: physlr_molecules.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
