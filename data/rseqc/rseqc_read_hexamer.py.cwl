cwlVersion: v1.2
class: CommandLineTool
baseCommand: [read_hexamer.py]
label: rseqc_read_hexamer.py
doc: "Calculate the hexamer frequency table of reads, a reference genome and reference mRNA sequences.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: input_read
    type:
      - type: array
        items: File
    doc: "Read sequence in fasta or fastq format. Multiple fasta/fastq files should be separated by ','."
    inputBinding:
      position: 1
      prefix: --input
      itemSeparator: ','
  - id: refgenome
    type:
      - 'null'
      - File
    doc: "Reference genome sequence in fasta format."
    inputBinding:
      position: 1
      prefix: --refgenome
  - id: refgene
    type:
      - 'null'
      - File
    doc: "Reference mRNA sequence in fasta format."
    inputBinding:
      position: 1
      prefix: --refgene
outputs:
  - id: stdout
    type: stdout
    doc: "Hexamer frequency table."
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
stdout: read_hexamer.txt
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
