cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - find_read_count.pl
label: mirdeep2_find_read_count.pl
doc: "Find the total read count of a collapsed fasta file whose identifiers end in the '_x<count>' format\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: fasta
    type: File
    doc: Fasta file with collapsed reads (identifiers like seq_0_x10)
    inputBinding:
      position: 1
outputs:
  - id: read_count
    type: stdout
    doc: Total read count
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: read_count.txt
