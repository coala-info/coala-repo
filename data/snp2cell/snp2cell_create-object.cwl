cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snp2cell
  - create-object
label: snp2cell_create-object
doc: "Create an initial SNP2CELL object holding a network. This can be used as an input for other sub-commands.\n\nTool homepage: https://github.com/Teichlab/snp2cell"
inputs:
  - id: nx_graph
    type: File
    doc: "path to pickled networkx graph"
    inputBinding:
      position: 1
  - id: out_name
    type: string
    doc: "output path for SNP2CELL object"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (log messages)
  - id: s2c_object
    type: File
    doc: The new SNP2CELL object
    outputBinding:
      glob: $(inputs.out_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
stdout: snp2cell_create-object.out
stderr: snp2cell_create-object.err
