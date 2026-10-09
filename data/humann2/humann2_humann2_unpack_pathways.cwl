cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_unpack_pathways
label: humann2_humann2_unpack_pathways
doc: "Unpack pathway abundances to show genes included\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
inputs:
  - id: input_genes
    type: File
    doc: "the gene family or EC abundance file"
    inputBinding:
      position: 101
      prefix: "--input-genes"
  - id: input_pathways
    type: File
    doc: "the pathway abundance file"
    inputBinding:
      position: 102
      prefix: "--input-pathways"
  - id: gene_mapping
    type:
      - 'null'
      - File
    doc: "gene family to reaction mapping file"
    inputBinding:
      position: 103
      prefix: "--gene-mapping"
  - id: pathway_mapping
    type:
      - 'null'
      - File
    doc: "reaction to pathway mapping file"
    inputBinding:
      position: 104
      prefix: "--pathway-mapping"
  - id: remove_taxonomy
    type:
      - 'null'
      - boolean
    doc: "remove the taxonomy from the output file"
    inputBinding:
      position: 105
      prefix: "--remove-taxonomy"
  - id: output_path
    type: string
    doc: "the table to write"
    inputBinding:
      position: 106
      prefix: "--output"
outputs:
  - id: output
    type: File
    doc: "unpacked pathway table"
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
