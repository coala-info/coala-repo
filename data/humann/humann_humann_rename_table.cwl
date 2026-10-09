cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann_rename_table
label: humann_humann_rename_table
doc: "HUMAnN utility for renaming table features\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann"
inputs:
  - id: input
    type: File
    doc: "Original output table (tsv or biom format)"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: names
    type:
      - 'null'
      - string
    doc: "Table features that can be renamed with included data files: kegg-orthology, kegg-pathway, kegg-module, ec, metacyc-rxn, metacyc-pwy, pfam, eggnog, go, infogo1000, uniref50"
    inputBinding:
      position: 102
      prefix: "--names"
  - id: custom
    type:
      - 'null'
      - File
    doc: "Custom mapping of feature IDs to full names (.tsv or .tsv.gz)"
    inputBinding:
      position: 103
      prefix: "--custom"
  - id: simplify
    type:
      - 'null'
      - boolean
    doc: "Remove non-alphanumeric characters from names"
    inputBinding:
      position: 104
      prefix: "--simplify"
  - id: output_path
    type: string
    doc: "Path for modified output table"
    inputBinding:
      position: 105
      prefix: "--output"
outputs:
  - id: output
    type: File
    doc: "table with renamed features"
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
