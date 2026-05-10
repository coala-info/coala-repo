cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metacache
  - merge
label: metacache_merge
doc: "Merge query files or directories with taxonomy information.\n\nTool homepage:
  https://github.com/muellan/metacache"
inputs:
  - id: query_file_directory
    type:
      type: array
      items: File
    doc: Query file or directory to merge
    inputBinding:
      position: 1
  - id: taxonomy_path
    type: Directory
    doc: Path to the taxonomy directory
    inputBinding:
      position: 102
      prefix: -taxonomy
  - id: result_path
    type: string
    doc: Output or path parameter `result_path`
    inputBinding:
      position: 103
      prefix: --result
outputs:
  - id: result
    type:
      - 'null'
      - File
    doc: Output file for the merge result
    outputBinding:
      glob: $(inputs.result_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
