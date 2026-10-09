cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hubward
  - process
label: hubward_process
doc: "Process one or many studies. Items can be directories containing metadata.yaml/metadata-builder.py\
  \ or a group configuration YAML file.\n\nTool homepage: https://github.com/daler/hubward"
inputs:
  - id: items
    type:
      type: array
      items: Directory
    doc: Path to directory containing metadata.yaml file or metadata-builder.py
      file. Can specify multiple. The directories are staged writable because
      the processed data is written inside them.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: processed_studies
    type:
      type: array
      items: Directory
    doc: The study directories with their raw-data and processed-data folders
    outputBinding:
      glob: '$(inputs.items.map(function(d) { return d.basename; }))'
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.items)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hubward:0.2.2--py27_1
stdout: hubward_process.out
