cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, refgenome, fragments-to-hicref]
label: pore-c_refgenome_fragments-to-hicref
doc: "Convert a *.fragments.parquet file to hicRef format.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: fragments_parquet
    type: File
    doc: "Fragments table (*.fragments.parquet)"
    inputBinding:
      position: 10
  - id: hicref
    type: string
    doc: "Output hicRef file name"
    inputBinding:
      position: 11
outputs:
  - id: hicref_file
    type: File
    doc: "hicRef file"
    outputBinding:
      glob: "$(inputs.hicref)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
