cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyctv.py
  - list
label: pyctv_taxonomy_list
doc: "Parse the current ICTV Virus Metadata Resource (VMR) workbook and print a list\
  \ of virus taxonomy.\n\nTool homepage: https://github.com/linsalrob/pyctv"
inputs:
  - id: semi
    type:
      - 'null'
      - boolean
    doc: Print semi-colon separated taxonomy
    inputBinding:
      position: 1
      prefix: --semi
  - id: genbank
    type:
      - 'null'
      - boolean
    doc: Print GenBank IDs and taxonomy
    inputBinding:
      position: 1
      prefix: --genbank
  - id: refseq
    type:
      - 'null'
      - boolean
    doc: Print RefSeq IDs and taxonomy
    inputBinding:
      position: 1
      prefix: --refseq
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: taxonomy_list
    type: stdout
    doc: Taxonomy list printed on standard output.
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyctv_taxonomy:0.25--pyhdfd78af_0
stdout: pyctv_taxonomy_list.out
