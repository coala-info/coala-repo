cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tigmint-arcs-tsv
label: tigmint_tigmint-arcs-tsv
doc: "Create a XXX.tigpair_checkpoint.tsv file from ARCS graph output that LINKS can utilize\n\nTool homepage: https://github.com/bcgsc/tigmint"
inputs:
  - id: graph_file
    type: File
    doc: "ARCS graph file output (.gv)"
    inputBinding:
      position: 1
  - id: out_file
    type: string
    doc: "Output file name. Must be named XXX.tigpair_checkpoint.tsv, where XXX is same as base name (-b) given to LINKS."
    inputBinding:
      position: 2
  - id: fasta_file
    type: File
    doc: "FASTA file of sequences to scaffold"
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: "Tigpair checkpoint TSV file for LINKS"
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
