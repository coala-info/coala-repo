cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ezaai
  - cluster
label: ezaai_cluster
doc: "Hierarchical clustering of taxa with AAI values\n\nTool homepage: http://leb.snu.ac.kr/ezaai"
inputs:
  - id: input_file
    type: File
    doc: Input EzAAI result file containing all-by-all pairwise AAI values
    inputBinding:
      position: 101
      prefix: -i
  - id: use_id
    type:
      - 'null'
      - boolean
    doc: Use ID instead of label for tree
    inputBinding:
      position: 101
      prefix: -u
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: Output result file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezaai:1.2.4--hdfd78af_0
