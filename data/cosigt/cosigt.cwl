cwlVersion: v1.2
class: CommandLineTool
baseCommand: cosigt
label: cosigt
doc: "genotyping loci in pangenome graphs using cosine distance\n\nTool homepage:
  https://github.com/davidebolo1993/cosigt"
inputs:
  - id: blacklist
    type:
      - 'null'
      - File
    doc: txt file with names of paths to exclude (one string per line)
    inputBinding:
      position: 101
      prefix: --blacklist
  - id: cluster
    type:
      - 'null'
      - File
    doc: cluster json file as generated with cluster.r
    inputBinding:
      position: 101
      prefix: --cluster
  - id: gafpack
    type: File
    doc: gzip-compressed tsv file with node coverages for a sample from gafpack
    inputBinding:
      position: 101
      prefix: --gafpack
  - id: id
    type: string
    doc: sample name
    inputBinding:
      position: 101
      prefix: --id
  - id: mask
    type:
      - 'null'
      - File
    doc: boolean mask to ignore node coverages (one boolean per line)
    inputBinding:
      position: 101
      prefix: --mask
  - id: paths
    type: File
    doc: gzip-compressed tsv file with path names and node coverages from odgi paths
    inputBinding:
      position: 101
      prefix: --paths
  - id: ploidy
    type:
      - 'null'
      - int
    doc: 'ploidy level (default: 2)'
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: weights
    type:
      - 'null'
      - File
    doc: file with node weights (one float64 per line)
    inputBinding:
      position: 101
      prefix: --weights
outputs:
  - id: output
    type: Directory
    doc: folder prefix for output files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cosigt:0.1.7--he881be0_0
