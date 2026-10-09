cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jclusterfunk
  - cluster
label: jclusterfunk_cluster
doc: "label clusters by number based on node attributes.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
  - id: attribute
    type: string
    doc: the attribute name
    inputBinding:
      position: 101
      prefix: --attribute
  - id: cluster_name
    type: string
    doc: the cluster name
    inputBinding:
      position: 101
      prefix: --cluster-name
  - id: cluster_prefix
    type:
      - 'null'
      - string
    doc: the cluster prefix (default = just a number)
    inputBinding:
      position: 101
      prefix: --cluster-prefix
  - id: format
    type:
      - 'null'
      - string
    doc: output file format (nexus or newick)
    inputBinding:
      position: 101
      prefix: --format
  - id: input_file
    type: File
    doc: input tree file
    inputBinding:
      position: 101
      prefix: --input
  - id: output_metadata
    type:
      - 'null'
      - string
    doc: output a metadata file to match the output tree
    inputBinding:
      position: 101
      prefix: --output-metadata
  - id: value
    type: string
    doc: the attribute value
    inputBinding:
      position: 101
      prefix: --value
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: write analysis details to console
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: output file
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: output_metadata_file
    type:
      - 'null'
      - File
    doc: metadata file matching the output tree
    outputBinding:
      glob: $(inputs.output_metadata)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
