cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, subgraphs]
label: physlr_subgraphs
doc: "Extract multiple vertex-induced subgraphs, one file per listed barcode, into an output directory.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: graph_files
    type: File[]
    doc: "Graph file(s) in TSV format"
    inputBinding:
      position: 100
  - id: vertices
    type: string
    doc: "comma-separated list of vertices"
    inputBinding:
      position: 1
      prefix: -v
  - id: exclude_vertices
    type: ['null', string]
    doc: "comma-separated list of vertices to exclude"
    inputBinding:
      position: 2
      prefix: --exclude-vertices
  - id: exclude_source
    type: ['null', int]
    doc: "exclude the barcode itself from the subgraph (0 or 1) [1 in the help text, 0 in the code]"
    inputBinding:
      position: 3
      prefix: --exclude-source
  - id: distance
    type: ['null', int]
    doc: "include vertices within this many edges away [0]"
    inputBinding:
      position: 4
      prefix: -d
  - id: distance_max
    type: ['null', int]
    doc: "maximum acceptable value for --distance, to avoid slow runs [20]"
    inputBinding:
      position: 5
      prefix: --distance-max
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
  - id: output_dir
    type: string
    doc: "the output directory (created by the tool); one <barcode>.<format> file is written per vertex with a non-empty subgraph"
    inputBinding:
      position: 20
      prefix: -o
outputs:
  - id: subgraphs_dir
    type: Directory
    doc: "Directory with one subgraph file per barcode"
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
