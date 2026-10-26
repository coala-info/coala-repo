cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cdbg-ops
  - extend
label: unitig-counter_cdbg-ops_extend
doc: "cdbg-ops extend: Extend sequence around a node by finding paths through it.\n\nTool homepage: https://github.com/johnlees/unitig-counter"
inputs:
  - id: nodes
    type: File
    doc: Name of .node file
    inputBinding:
      position: 101
      prefix: --nodes
  - id: edges
    type: File
    doc: Name of .edges.dbg file
    inputBinding:
      position: 101
      prefix: --edges
  - id: unitigs
    type: File
    doc: File containing unitigs to extend
    inputBinding:
      position: 101
      prefix: --unitigs
  - id: length
    type:
      - 'null'
      - int
    doc: Maximum extension length [100]
    inputBinding:
      position: 101
      prefix: --length
  - id: repeats
    type:
      - 'null'
      - boolean
    doc: Allow loops in extensions
    inputBinding:
      position: 101
      prefix: --repeats
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the extended sequences
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unitig-counter:1.1.0--h5ca1c30_2
stdout: unitig-counter_cdbg-ops_extend.out
