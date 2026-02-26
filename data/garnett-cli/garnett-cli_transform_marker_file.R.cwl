cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/transform_marker_file.R
label: garnett-cli_transform_marker_file.R
doc: "Transforms marker gene files into a format suitable for Garnett.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/garnett-cli"
inputs:
  - id: gene_names
    type:
      - 'null'
      - string
    doc: Column containing gene names in marker file
    inputBinding:
      position: 101
      prefix: --gene-names
  - id: groups_col
    type:
      - 'null'
      - string
    doc: Column name of cell groups (i.e. cluster IDs or cell types) in marker 
      file
    inputBinding:
      position: 101
      prefix: --groups-col
  - id: input_marker_file
    type:
      - 'null'
      - File
    doc: Path to the SCXA-style marker gene file in .txt format
    inputBinding:
      position: 101
      prefix: --input-marker-file
  - id: marker_list
    type:
      - 'null'
      - File
    doc: Path to a serialised object containing marker genes
    inputBinding:
      position: 101
      prefix: --marker-list
  - id: pval_col
    type:
      - 'null'
      - string
    doc: Column name of marker p-values
    inputBinding:
      position: 101
      prefix: --pval-col
  - id: pval_threshold
    type:
      - 'null'
      - float
    doc: Cut-off p-value for marker genes
    inputBinding:
      position: 101
      prefix: --pval-threshold
outputs:
  - id: garnett_marker_file
    type:
      - 'null'
      - File
    doc: Path to the garnett format marker gene file in .txt format
    outputBinding:
      glob: $(inputs.garnett_marker_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
