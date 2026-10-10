cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - collapse_reads_md.pl
label: mirdeep2_collapse_reads_md.pl
doc: "Collapse the reads in a fasta file so that each sequence entry is unique; identifiers have the form prefix_number_xcount\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: reads
    type: File
    doc: Fasta file with the reads
    inputBinding:
      position: 1
  - id: prefix
    type: string
    doc: Three-letter sample prefix (exactly three alphabetic letters) used in the new identifiers
    inputBinding:
      position: 2
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Output progress
    inputBinding:
      position: 101
      prefix: -a
outputs:
  - id: collapsed_reads
    type: stdout
    doc: Collapsed reads in fasta format
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: collapsed_reads.fa
