cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hmnfusion
  - download-zenodo
label: hmnfusion_download-zenodo
doc: "Download files from a Zenodo repository\n\nTool homepage: https://github.com/guillaume-gricourt/HmnFusion"
inputs:
  - id: input_token_str
    type:
      - 'null'
      - string
    doc: Token string to access into repository with restricted access
    inputBinding:
      position: 101
      prefix: --input-token-str
  - id: input_token_txt
    type:
      - 'null'
      - File
    doc: File with token to access into repository with restricted access
    inputBinding:
      position: 101
      prefix: --input-token-txt
  - id: input_zenodo_str
    type: string
    doc: Id of Zenodo repository
    inputBinding:
      position: 101
      prefix: --input-zenodo-str
outputs:
  - id: output_directory
    type: Directory
    doc: Directory to write files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
