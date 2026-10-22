cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snp2cell
  - create-gene2pos-mapping
label: snp2cell_create-gene2pos-mapping
doc: "Query pybiomart to obtain genomic locations for genes in the network in the s2c object and save them to a csv file.\n\nTool homepage: https://github.com/Teichlab/snp2cell"
inputs:
  - id: pos2gene_csv
    type:
      - 'null'
      - string
    doc: "output path for csv file with mapping (default pos2gene.csv)"
    inputBinding:
      position: 2
  - id: biomart_host
    type:
      - 'null'
      - string
    doc: "biomart host to use; default: newest (http://www.ensembl.org)"
    inputBinding:
      position: 1
      prefix: --biomart-host
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (log messages)
  - id: pos2gene_out
    type:
      - 'null'
      - File
    doc: The gene to genomic position mapping
    outputBinding:
      glob: "$(inputs.pos2gene_csv ? inputs.pos2gene_csv : 'pos2gene.csv')"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
stdout: snp2cell_create-gene2pos-mapping.out
stderr: snp2cell_create-gene2pos-mapping.err
