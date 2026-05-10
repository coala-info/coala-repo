cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - autocycler
  - clean
label: autocycler_clean
doc: "manual manipulation of the final consensus assebly graph\n\nTool homepage: https://github.com/rrwick/Autocycler"
inputs:
  - id: duplicate
    type:
      - 'null'
      - string
    doc: Tig numbers to duplicate in the input graph
    inputBinding:
      position: 101
      prefix: --duplicate
  - id: in_gfa
    type: File
    doc: Autocycler GFA file (required)
    inputBinding:
      position: 101
      prefix: --in_gfa
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Automatically remove tigs up to this depth
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: remove
    type:
      - 'null'
      - string
    doc: Tig numbers to remove from the input graph
    inputBinding:
      position: 101
      prefix: --remove
  - id: out_gfa_path
    type: string
    doc: Output or path parameter `out_gfa_path`
    inputBinding:
      position: 102
      prefix: --out-gfa
outputs:
  - id: out_gfa
    type: File
    doc: Output GFA file (required)
    outputBinding:
      glob: $(inputs.out_gfa_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
