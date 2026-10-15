cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanini_cluster2genes
label: ppanini_cluster2genes
doc: "Make a map table (cluster, genes separated by ;, representative gene) from a CD-HIT cluster output.\n\nTool homepage: http://huttenhower.sph.harvard.edu/ppanini"
inputs:
  - id: cd_hit
    type:
      - 'null'
      - File
    doc: "CD-HIT clusters output (.clstr)"
    inputBinding:
      position: 101
      prefix: -i
  - id: json
    type:
      - 'null'
      - boolean
    doc: "Also write the map as JSON"
    inputBinding:
      position: 101
      prefix: --json
  - id: output_path
    type: string
    doc: "Output directory (created by the tool)"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: Directory
    doc: "Directory with cd-hit_gene_map.txt (and .json)"
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanini:0.7.4--py_0
stdout: ppanini_cluster2genes.out
