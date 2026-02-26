cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hubward
  - process
label: hubward_process
doc: "Process one or many studies. Items can be directories containing metadata.yaml/metadata-builder.py
  or a group configuration YAML file.\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: items
    type:
      type: array
      items: File
    doc: Path to directory containing metadata.yaml file or 
      metadata-builder.yaml file, or path to a group config YAML file. Can 
      specify multiple.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hubward:0.2.2--py27_1
stdout: hubward_process.out
