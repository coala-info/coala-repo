cwlVersion: v1.2
class: CommandLineTool
baseCommand: itolexport.py
label: itolapi_itolexport.py
doc: "Export trees from iTOL (Interactive Tree Of Life) using the API.\n\nTool homepage:
  https://github.com/albertyw/itolapi"
inputs:
  - id: api_key
    type: string
    doc: Your iTOL API key
    inputBinding:
      position: 101
      prefix: --api_key
  - id: dataset_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma separated list of dataset IDs to include
    inputBinding:
      position: 101
      prefix: --dataset_list
  - id: format
    type: string
    doc: Output format (pdf, svg, eps, ps, png, jpg, nexus, newick)
    inputBinding:
      position: 101
      prefix: --format
  - id: project_name
    type: string
    doc: Project name on iTOL
    inputBinding:
      position: 101
      prefix: --project_name
  - id: tree_id
    type: string
    doc: iTOL tree ID
    inputBinding:
      position: 101
      prefix: --tree_id
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output file path
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itolapi:4.1.6--pyhdfd78af_0
