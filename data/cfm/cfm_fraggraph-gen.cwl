cwlVersion: v1.2
class: CommandLineTool
baseCommand: fraggraph-gen
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
    inputBinding:
      position: 4
  - id: output_filename
    type:
      - 'null'
      - string
    doc: Optional output filename (defaults to stdout); needs graph_type
    inputBinding:
      position: 5
outputs:
  - id: stdout
    type: stdout
    doc: Fragmentation graph (when no output file is given)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Fragmentation graph written to output_filename
    outputBinding:
      glob: $(inputs.output_filename)
stdout: cfm_fraggraph-gen.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cfm:33--h7600467_7
