cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3sort.pl
label: gff3sort
doc: "A script to sort GFF3 files for tabix indexing. It can handle nested features
  and ensures that parent features always appear before their children.\n\nTool homepage:
  https://github.com/billzt/gff3sort"
inputs:
  - id: input_file
    type: File
    doc: Input GFF3 file to be sorted
    inputBinding:
      position: 1
  - id: chr_order
    type:
      - 'null'
      - string
    doc: "Specify the chromosome sorting order: 'natural', 'alphabetical', or a path
      to a file containing the desired order"
    inputBinding:
      position: 102
      prefix: --chr_order
  - id: extract_child
    type:
      - 'null'
      - boolean
    doc: Extract child features and sort them according to their parent features
    inputBinding:
      position: 102
      prefix: --extract_child
  - id: precise
    type:
      - 'null'
      - boolean
    doc: Run in precise mode, which is slower but handles complex nested features
      more accurately
    inputBinding:
      position: 102
      prefix: --precise
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3sort:0.1.a1a2bc9--pl526_0
stdout: gff3sort.out
