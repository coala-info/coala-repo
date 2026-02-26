cwlVersion: v1.2
class: CommandLineTool
baseCommand: mice
label: mice
doc: "Parse paths from a GFF/GFA file\n\nTool homepage: https://github.com/gi-bielefeld/mice"
inputs:
  - id: graph_input
    type: File
    doc: Input graph file
    inputBinding:
      position: 1
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum element length (in bp) to keep elements that were not merged 
      after the first compression. Compression is first performed. Elements that
      remain unmerged and are shorter than this length are then removed, and 
      compression is performed again.
    default: 0
    inputBinding:
      position: 102
      prefix: --min-size
  - id: no_group_by
    type:
      - 'null'
      - boolean
    doc: If set every path is treated as its own genome
    inputBinding:
      position: 102
      prefix: --no-group-by
  - id: remove_dup
    type:
      - 'null'
      - int
    doc: Remove an element if it occurs more than x times in any genome. Use 0 
      to disable removal
    default: 0
    inputBinding:
      position: 102
      prefix: --remove-dup
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mice:0.1.2--h4349ce8_0
