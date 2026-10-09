cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - howdesbt
  - querybf
label: howdesbt_querybf
doc: "query a bloom filter, listing the kmers that \"hit\"\n\nTool homepage: https://github.com/medvedevgroup/HowDeSBT"
inputs:
  - id: query_files
    type:
      type: array
      items: File
    doc: "names of query files; each is either a fasta file or a file with one nucleotide sequence per line"
    inputBinding:
      position: 101
  - id: filter
    type:
      type: array
      items: File
      inputBinding:
        prefix: "--filter="
        separate: false
    doc: "bloom filter file (usually .bf); can be given more than once"
    inputBinding:
      position: 102
  - id: threshold
    type:
      - 'null'
      - float
    doc: "fraction of query kmers that must be present in a filter to be considered a match; between 0 and 1 (default is 0.7)"
    inputBinding:
      position: 103
      prefix: "--threshold="
      separate: false
  - id: distinctkmers
    type:
      - 'null'
      - boolean
    doc: "perform the query counting each distinct kmer only once"
    inputBinding:
      position: 104
      prefix: "--distinctkmers"
  - id: report_all
    type:
      - 'null'
      - boolean
    doc: "report both present and absent kmers (by default only present kmers are reported)"
    inputBinding:
      position: 105
      prefix: "--report:all"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/howdesbt:2.00.15--h9948957_2
stdout: howdesbt_querybf.out
