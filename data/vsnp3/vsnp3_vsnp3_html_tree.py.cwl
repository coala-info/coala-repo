cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_html_tree.py
label: vsnp3_vsnp3_html_tree.py
doc: "Create an interactive phylogenetic tree (HTML) from an SNP alignment Excel file.\n\n\
  Tool homepage: https://github.com/USDA-VS/vsnp3"
inputs:
  - id: file
    type: File
    doc: Input Excel file containing SNP alignment
    inputBinding:
      position: 101
      prefix: -f
      valueFrom: $(self.basename)
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output HTML file name (default: phylo_tree.html)'
    inputBinding:
      position: 101
      prefix: -o
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: 'Number of bootstrap replicates (default: 100)'
    inputBinding:
      position: 101
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: html
    type:
      type: array
      items: File
    doc: Interactive tree
    outputBinding:
      glob: '*.html'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_html_tree.py.stdout.txt
