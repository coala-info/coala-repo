cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaselect.pl
label: mirdeep2_fastaselect.pl
doc: "Print the fasta entries whose identifier is present (or, with invert, absent) in an identifier file\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: fasta
    type: File
    doc: Fasta file to select from
    inputBinding:
      position: 1
  - id: id_file
    type: File
    doc: File with the identifiers to select, one per line (first word of each line)
    inputBinding:
      position: 2
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Print only entries whose identifier is not present in the id file
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: selected_fasta
    type: stdout
    doc: Selected fasta entries
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: selected.fa
