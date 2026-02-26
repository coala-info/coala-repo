cwlVersion: v1.2
class: CommandLineTool
baseCommand: snp2cell_create-gene2pos-mapping
label: snp2cell_create-gene2pos-mapping
doc: "Create a gene to genomic position mapping.\n\nTool homepage: https://github.com/Teichlab/snp2cell"
inputs:
  - id: host
    type: string
    doc: Biomart host to query for gene locations.
    inputBinding:
      position: 101
      prefix: --host
  - id: pos2gene_csv
    type: File
    doc: Path to save the gene to genomic position mapping CSV file.
    inputBinding:
      position: 101
      prefix: --pos2gene_csv
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
stdout: snp2cell_create-gene2pos-mapping.out
