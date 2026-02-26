cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - barcodeforge
  - extract-auspice-data
label: barcodeforge_extract-auspice-data
doc: "Extract metadata and tree from an Auspice JSON file. Inspired by Dr. John Huddleston's
  Gist on processing Auspice JSON files. Source: https://gist.github.com/huddlej/5d7bd023d3807c698bd18c706974f2db\n\
  \nTool homepage: https://github.com/andersen-lab/BarcodeForge"
inputs:
  - id: auspice_json_path
    type: File
    doc: Path to the Auspice JSON file
    inputBinding:
      position: 1
  - id: attributes
    type:
      - 'null'
      - string
    doc: Attributes to include in the metadata table (e.g., 'country', 'date').
    inputBinding:
      position: 102
      prefix: --attributes
  - id: include_internal_nodes
    type:
      - 'null'
      - boolean
    doc: Include internal nodes in the output tree.
    inputBinding:
      position: 102
      prefix: --include_internal_nodes
outputs:
  - id: output_metadata_path
    type:
      - 'null'
      - File
    doc: Path to save the metadata table (TSV format).
    outputBinding:
      glob: $(inputs.output_metadata_path)
  - id: output_tree_path
    type:
      - 'null'
      - File
    doc: Path to save the tree in Newick format.
    outputBinding:
      glob: $(inputs.output_tree_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barcodeforge:1.1.2--pyhdfd78af_0
