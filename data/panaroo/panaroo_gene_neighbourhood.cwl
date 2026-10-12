cwlVersion: v1.2
class: CommandLineTool
baseCommand: panaroo-gene-neighbourhood
label: panaroo_gene_neighbourhood
doc: "Explore the neighbourhood of a gene in a Panaroo pangenome graph.

Tool homepage: https://gtonkinhill.github.io/panaroo"
inputs:
  - id: gene
    type: string
    doc: "Gene of interest."
    inputBinding:
      prefix: --gene
  - id: genome_id
    type:
      - 'null'
      - string
    doc: "Genome ID of interest (default ALL)."
    inputBinding:
      prefix: --genome_id
  - id: graph
    type: File
    doc: "Genome graph gml ('final_graph.gml')."
    inputBinding:
      prefix: --graph
  - id: expand_no
    type:
      - 'null'
      - int
    doc: "Length of the path that is expanded around the target gene (default 5)."
    inputBinding:
      prefix: --expand_no
  - id: out
    type:
      - 'null'
      - string
    doc: "Output file."
    inputBinding:
      prefix: --out
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Gene neighbourhood output file."
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
stdout: panaroo_gene_neighbourhood.out
