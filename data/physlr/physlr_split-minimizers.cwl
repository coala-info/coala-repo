cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, split-minimizers]
label: physlr_split-minimizers
doc: "Given the molecule overlap graph, split the minimizers of each barcode into molecules. The vertices of the graph must be named barcode_N_M (for example barcode_0_0); a graph with barcode_N names gives an empty result.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: threads
    type: ['null', int]
    doc: "number of threads [16 or number of CPU]"
    inputBinding:
      position: 1
      prefix: -t
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 2
      prefix: -V
  - id: graph_file
    type: File
    doc: "Molecule overlap graph in TSV format (vertices named barcode_N_M)"
    inputBinding:
      position: 100
  - id: minimizers_file
    type: File
    doc: "Minimizers in TSV format: barcode, a tab, then space-separated minimizers (as written by physlr-indexlr)"
    inputBinding:
      position: 101
outputs:
  - id: result
    type: File
    doc: "TSV table: molecule name, a tab, then the space-separated minimizers of that molecule"
    outputBinding:
      glob: physlr_split-minimizers.tsv
stdout: physlr_split-minimizers.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
