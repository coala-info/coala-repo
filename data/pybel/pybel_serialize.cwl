cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pybel
  - serialize
label: pybel_serialize
doc: "Serialize a graph to various formats.\n\nTool homepage: https://pybel.readthedocs.io"
inputs:
  - id: path
    type: File
    doc: "Compiled graph pickle written by pybel compile (a BEL script path also works when its compiled pickle is beside it)"
    inputBinding:
      position: 1
  - id: csv
    type:
      - 'null'
      - string
    doc: "Path to output a CSV file."
    inputBinding:
      position: 10
      prefix: --csv
  - id: sif
    type:
      - 'null'
      - string
    doc: "Path to output an SIF file."
    inputBinding:
      position: 10
      prefix: --sif
  - id: gsea
    type:
      - 'null'
      - string
    doc: "Path to output a GRP file for gene set enrichment analysis."
    inputBinding:
      position: 10
      prefix: --gsea
  - id: graphml
    type:
      - 'null'
      - string
    doc: "Path to output a GraphML file. Use .graphml for Cytoscape."
    inputBinding:
      position: 10
      prefix: --graphml
  - id: json
    type:
      - 'null'
      - string
    doc: "Path to output a node-link JSON file."
    inputBinding:
      position: 10
      prefix: --json
  - id: bel
    type:
      - 'null'
      - string
    doc: "Output canonical BEL."
    inputBinding:
      position: 10
      prefix: --bel
outputs:
  - id: csv_file
    type:
      - 'null'
      - File
    doc: "CSV file"
    outputBinding:
      glob: $(inputs.csv)
  - id: sif_file
    type:
      - 'null'
      - File
    doc: "SIF file"
    outputBinding:
      glob: $(inputs.sif)
  - id: gsea_file
    type:
      - 'null'
      - File
    doc: "GRP file"
    outputBinding:
      glob: $(inputs.gsea)
  - id: graphml_file
    type:
      - 'null'
      - File
    doc: "GraphML file"
    outputBinding:
      glob: $(inputs.graphml)
  - id: json_file
    type:
      - 'null'
      - File
    doc: "Node-link JSON file"
    outputBinding:
      glob: $(inputs.json)
  - id: bel_file
    type:
      - 'null'
      - File
    doc: "Canonical BEL file"
    outputBinding:
      glob: $(inputs.bel)
  - id: stdout_text
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_serialize.out
