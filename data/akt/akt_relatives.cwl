cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ./akt
  - unrelated
label: akt_relatives
doc: "Derive a set of pedigrees from the akt kin output.\n\nTool homepage: https://github.com/Illumina/akt"
inputs:
  - id: ibd_file
    type: File
    doc: akt kin output file
    inputBinding:
      position: 1
  - id: iterations
    type:
      - 'null'
      - int
    doc: number of iterations to find unrelated
    inputBinding:
      position: 102
      prefix: --its
  - id: kmin
    type:
      - 'null'
      - float
    doc: threshold for relatedness
    inputBinding:
      position: 102
      prefix: --kmin
  - id: graph_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `graph_out_path`
    inputBinding:
      position: 103
      prefix: --graph-out
  - id: prefix_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `prefix_path`
    inputBinding:
      position: 104
      prefix: --prefix
outputs:
  - id: graph_out
    type:
      - 'null'
      - File
    doc: if present output pedigree graph files
    outputBinding:
      glob: $(inputs.graph_out_path)
  - id: prefix
    type:
      - 'null'
      - File
    doc: output file prefix
    outputBinding:
      glob: $(inputs.prefix_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/akt:0.3.3--h5ca1c30_7
