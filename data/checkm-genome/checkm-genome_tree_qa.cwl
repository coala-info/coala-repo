cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - checkm
  - tree_qa
label: checkm-genome_tree_qa
doc: "Assess phylogenetic markers found in each bin.\n\nTool homepage: https://github.com/Ecogenomics/CheckM"
inputs:
  - id: tree_dir
    type: Directory
    doc: 'directory specified during tree command'
    inputBinding:
      position: 1
  - id: out_format
    type:
      - 'null'
      - int
    doc: 'desired output: 1. brief summary of genome tree placement; 2. detailed
      summary including lineage-specific statistics; 3. genome tree in Newick format
      decorated with IMG genome ids; 4. genome tree in Newick format decorated with
      taxonomy strings; 5. multiple sequence alignment of reference genomes and bins
      (default: 1)'
    inputBinding:
      position: 101
      prefix: --out_format
  - id: file
    type:
      - 'null'
      - string
    doc: 'print results to file (default: stdout)'
    inputBinding:
      position: 101
      prefix: --file
  - id: tab_table
    type:
      - 'null'
      - boolean
    doc: 'print tab-separated values table'
    inputBinding:
      position: 101
      prefix: --tab_table
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'suppress console output'
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: 'specify an alternative directory for temporary files'
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: file_out
    type:
      - 'null'
      - File
    doc: 'print results to file (default: stdout)'
    outputBinding:
      glob: $(inputs.file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkm-genome:1.2.4--pyhdfd78af_2
stdout: checkm-genome_tree_qa.out
