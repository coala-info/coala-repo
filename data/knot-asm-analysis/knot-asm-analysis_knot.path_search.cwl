cwlVersion: v1.2
class: CommandLineTool
baseCommand: knot.path_search
label: knot-asm-analysis_knot.path_search
doc: "Search the paths between contig extremities and write the assembly-assembly graph (AAG)\n\nTool homepage: https://github.com/natir/knot"
inputs:
  - id: search_mode
    type:
      - 'null'
      - string
    doc: what path search optimize, number of base or number of node (base or node)
    inputBinding:
      position: 101
      prefix: --search-mode
  - id: self_lookup
    type:
      - 'null'
      - boolean
    doc: if it set knot search path between extremity of same contig
    inputBinding:
      position: 101
      prefix: --self-lookup
  - id: search
    type: File
    doc: extremity table written by knot.extremity_search
    inputBinding:
      position: 1
  - id: result
    type: string
    doc: output AAG file
    inputBinding:
      position: 2
  - id: ovl_graph
    type: File
    doc: read overlap graph (GFA)
    inputBinding:
      position: 3
  - id: read2asm
    type: File
    doc: reads mapped on the assembly (PAF)
    inputBinding:
      position: 4
  - id: asm_graph
    type: File
    doc: assembly graph (GFA)
    inputBinding:
      position: 5
  - id: tig2tig
    type: File
    doc: contig overlap graph (GFA)
    inputBinding:
      position: 6
outputs:
  - id: aag
    type: File
    doc: assembly-assembly graph
    outputBinding:
      glob: $(inputs.result)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/knot-asm-analysis:1.3.0--py_0
