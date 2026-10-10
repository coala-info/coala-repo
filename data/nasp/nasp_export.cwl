cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nasp, export]
label: nasp_export
doc: "Transform a NASP matrix to FASTA or VCF format.\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: type
    type:
      - 'null'
      - string
    doc: "Output type: vcf (default) or fasta."
    inputBinding:
      position: 1
      prefix: --type
  - id: nasp_matrix
    type: File
    doc: "NASP matrix (tsv)."
    inputBinding:
      position: 101
outputs:
  - id: output
    type: stdout
    doc: "Exported FASTA or VCF, written to standard output."
stdout: nasp_export.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
