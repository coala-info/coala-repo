cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - subgraph
label: sga_subgraph
doc: "Extract the subgraph around the sequence with ID from an asqg file.\n\nTool
  homepage: https://github.com/jts/sga"
inputs:
  - id: id
    type: string
    doc: The sequence ID around which to extract the subgraph
    inputBinding:
      position: 1
  - id: asqg_file
    type: File
    doc: The input ASQG file
    inputBinding:
      position: 2
  - id: size
    type:
      - 'null'
      - int
    doc: the size of the subgraph to extract, all vertices that are at most N 
      hops away from the root will be included
    inputBinding:
      position: 103
      prefix: --size
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write the subgraph to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
