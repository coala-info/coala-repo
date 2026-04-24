cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hubward
  - skeleton
label: hubward_skeleton
doc: "Populate <dirname> with template files that can be customized on a per-study
  basis. The skeleton is actually a working example.\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: use_metadata_builder
    type:
      - 'null'
      - boolean
    doc: Sets up a metadata-builder.py script instead of a metadata.yaml config 
      file. Useful for more complicated studies
    inputBinding:
      position: 101
      prefix: --use-metadata-builder
outputs:
  - id: dirname
    type: Directory
    doc: Path to contain skeleton project
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hubward:0.2.2--py27_1
