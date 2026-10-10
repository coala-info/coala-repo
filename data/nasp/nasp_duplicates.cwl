cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nasp, duplicates]
label: nasp_duplicates
doc: "Identify duplicate regions in the reference genome contigs from a nucmer delta file (reference aligned to itself and filtered with delta-filter -q -r).\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: type
    type:
      - 'null'
      - string
    doc: "Output type: fasta (binary 0/1 sequence, default) or range (contig, start, end per duplicate region)."
    inputBinding:
      position: 1
      prefix: --type
  - id: reference_delta
    type: File
    doc: "Delta-filtered nucmer delta file of the reference against itself."
    inputBinding:
      position: 101
outputs:
  - id: output
    type: stdout
    doc: "Duplicates table, written to standard output."
stdout: nasp_duplicates.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
