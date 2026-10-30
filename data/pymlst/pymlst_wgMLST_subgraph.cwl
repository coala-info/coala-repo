cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wgMLST
  - subgraph
label: pymlst_wgMLST_subgraph
doc: "Searches group of strains at a DISTANCE threshold.\n\nTool homepage: https://github.com/bvalot/pyMLST"
inputs:
  - id: distance
    type: File
    doc: "Distance matrix (output of wgMLST distance)"
    inputBinding:
      position: 1
  - id: output_path
    type: ['null', string]
    doc: "Output group files (default:stdout)."
    inputBinding:
      position: 10
      prefix: --output
  - id: threshold
    type: ['null', int]
    doc: "Minimum distance to conserve for extraction of group (default:50)."
    inputBinding:
      position: 10
      prefix: --threshold
  - id: export
    type: ['null', {type: enum, symbols: [list, count, group]}]
    doc: "Export type (default:list)."
    inputBinding:
      position: 10
      prefix: --export
outputs:
  - id: output
    type: ['null', File]
    doc: "Groups written with output_path"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Standard output (result when no output file is given)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymlst:2.2.2--pyhdfd78af_0
stdout: pymlst_wgMLST_subgraph.out
