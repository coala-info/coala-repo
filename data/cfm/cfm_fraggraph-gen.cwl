cwlVersion: v1.2
class: CommandLineTool
baseCommand: fraggraph-gen.exe
label: cfm_fraggraph-gen
doc: "Generates a fragmentation graph from a molecule.\n\nTool homepage: https://sourceforge.net/p/cfm-id/wiki/Home/"
inputs:
  - id: smiles_or_inchi
    type: string
    doc: SMILES or InChI string of the molecule
    inputBinding:
      position: 1
  - id: max_depth
    type: int
    doc: Maximum fragmentation depth
    inputBinding:
      position: 2
  - id: ionization_mode
    type: string
    doc: Ionization mode (+ for Positive ESI, - for Negative ESI, * for Positive
      EI)
    inputBinding:
      position: 3
  - id: graph_type
    type:
      - 'null'
      - string
    doc: Type of graph to generate (fullgraph or fragonly)
    default: fullgraph
    inputBinding:
      position: 4
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Optional output filename (defaults to stdout)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cfm:33--h7600467_7
