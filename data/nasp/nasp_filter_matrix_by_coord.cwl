cwlVersion: v1.2
class: CommandLineTool
baseCommand: [filter_matrix_by_coord.py]
label: nasp_filter_matrix_by_coord
doc: "Keep or remove the listed SNPs (LocusIDs) of a NASP matrix.\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: in_matrix
    type: File
    doc: "Path to the NASP matrix."
    inputBinding:
      position: 1
      prefix: --in_matrix
  - id: out_prefix
    type: string
    doc: "Prefix for output files."
    inputBinding:
      position: 1
      prefix: --out_prefix
  - id: in_coords
    type: File
    doc: "Path to a file listing the LocusIDs (contig::position) to keep or remove, one per line."
    inputBinding:
      position: 1
      prefix: --in_coords
  - id: action
    type:
      - 'null'
      - string
    doc: "Keep SNPs in range or remove them (keep or remove, default keep)."
    inputBinding:
      position: 1
      prefix: --action
outputs:
  - id: outputs
    type:
      type: array
      items: File
    doc: "Files written with the output prefix."
    outputBinding:
      glob: $(inputs.out_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
