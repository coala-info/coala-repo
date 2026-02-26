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
outputs:
  - id: result
    type:
      - 'null'
      - File
    doc: Output file for the merge result
    outputBinding:
      glob: $(inputs.result)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
